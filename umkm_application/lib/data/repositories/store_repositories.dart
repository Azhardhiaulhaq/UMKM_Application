import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';

class StoreRepository {
  static FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  static FirebaseFirestore firestore = FirebaseFirestore.instance;
  static CollectionReference users = firestore.collection('users');

  static Future<void> updateImage(String uid, File imageFile) async {
    try {
      String fileName = basename(imageFile.path);
      var firebaseStorageRef =
          FirebaseStorage.instance.ref().child('users').child('$fileName');
      UploadTask uploadTask = firebaseStorageRef.putFile(imageFile);
      var taskSnapshot = await uploadTask.whenComplete(() {});
      var urlDownload = await taskSnapshot.ref.getDownloadURL();
      await users.doc(uid).update({'image': urlDownload});
    } catch (e) {
      print(e.toString());
    }
  }

  static Future<void> updateStore(
      String address,
      bukalapak_name,
      city,
      description,
      email,
      facebook_acc,
      instagram_acc,
      phone_number,
      province,
      shoope_name,
      tokopedia_name,
      umkm_name,
      youtube_link,
      uid,
      List<String> tag) async {
    try {
      await users.doc(uid).update({
        'address': address,
        'bukalapak_name': bukalapak_name,
        'city': city,
        'description': description,
        'email': email,
        'facebook_acc': facebook_acc,
        'instagram_acc': instagram_acc,
        'phone_number': phone_number,
        'province': province,
        'shoope_name': shoope_name,
        'tag': tag,
        'tokopedia_name': tokopedia_name,
        'youtube_link': youtube_link,
        'umkm_name': umkm_name,
      });
    } catch (e) {
      print(e.toString());
    }
  }

  static Future<void> addProduct(
      String uid,String name, String description, File image, int price) async {
    try {
      String fileName = basename(image.path);
      var firebaseStorageRef = FirebaseStorage.instance
          .ref()
          .child('users')
          .child('products')
          .child('$fileName');
      UploadTask uploadTask = firebaseStorageRef.putFile(image);
      var taskSnapshot = await uploadTask.whenComplete(() {});
      var urlDownload = await taskSnapshot.ref.getDownloadURL();
      await users.doc(uid).collection("products").add({
        'name': name.toUpperCase(),
        'description': description,
        'image': urlDownload,
        'price': price
      });
    } catch (e) {
      print(e.toString());
    }
  }

  static Future<void> deleteProduct(String uid, String productid) async{
    try{
      await users.doc(uid).collection('products').doc(productid).delete();
    } catch(e){
      print(e);
    }
  }

  static Future<void> updateProduct(String uid, String productid, String name, String description,
      File image, int price, String imageLink) async {
    try {
      var urlDownload;
      if (File(image.path).existsSync()) {
        String fileName = basename(image.path);
        var firebaseStorageRef = FirebaseStorage.instance
            .ref()
            .child('users')
            .child('products')
            .child('$fileName');
        UploadTask uploadTask = firebaseStorageRef.putFile(image);
        var taskSnapshot = await uploadTask.whenComplete(() {});
        urlDownload = await taskSnapshot.ref.getDownloadURL();
      } else {
        urlDownload = imageLink;
      }

      await users.doc(uid).collection("products").doc(productid).update({
        'name': name.toUpperCase(),
        'description': description,
        'image': urlDownload,
        'price': price
      });
    } catch (e) {
      print(e.toString());
    }
  }
}
