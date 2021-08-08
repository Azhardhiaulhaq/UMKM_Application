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

  static Future<void> updateEvent(String eventID, String author, String imageLink,
      File image, String contact_person, DateTime date, String description, String link, 
      String location, String name) async {
    try {
      var urlDownload;
      if (File(image.path).existsSync()) {
        String fileName = basename(image.path);
        var firebaseStorageRef = FirebaseStorage.instance
            .ref()
            .child('events')
            .child('$fileName');
        UploadTask uploadTask = firebaseStorageRef.putFile(image);
        var taskSnapshot = await uploadTask.whenComplete(() {});
        urlDownload = await taskSnapshot.ref.getDownloadURL();
      } else {
        urlDownload = imageLink;
      }

      await events.doc(eventID).update({
        'author' : author,
        'banner_image' : urlDownload,
        'contact_person' : contact_person,
        'date' : Timestamp.fromDate(date),
        'description' : description,
        'link' : link,
        'location' : location,
        'name' : name,
      });
    } catch (e) {
      print(e.toString());
    }
  }

    static Future<void> deleteProduct(String eventID) async{
    try{
      await events..doc(eventID).delete();
    } catch(e){
      print(e);
    }
  }
}
