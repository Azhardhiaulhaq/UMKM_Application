import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';

class EventRepository {
  static FirebaseFirestore firestore = FirebaseFirestore.instance;
  static CollectionReference events = firestore.collection('events');
  static Future<String?> uploadImage(File imageFile) async {
    try {
      String fileName = basename(imageFile.path);
      var firebaseStorageRef =
          FirebaseStorage.instance.ref().child('events').child('$fileName');
      UploadTask uploadTask = firebaseStorageRef.putFile(imageFile);
      var taskSnapshot = await uploadTask.whenComplete(() {});
      var urlDownload = await taskSnapshot.ref.getDownloadURL();
      return urlDownload;
    } catch (e) {
      print(e.toString());
    }
  }

  static Future addEvent(
      String name,
      String location,
      String description,
      String author,
      String link,
      String contactPerson,
      DateTime date,
      String imageLink) async {
    try {
      Timestamp time = Timestamp.fromDate(date);
      await events.add({
        'author' : author,
        'banner_image' : imageLink,
        'contact_person' : contactPerson,
        'date' : time,
        'description' : description,
        'link' : link,
        'location' : location,
        'name' : name.toUpperCase()
      });
    } catch (e) {
      print(e.toString());
    }
  }
}
