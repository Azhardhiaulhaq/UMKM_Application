import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';
import 'package:umkm_application/Model/store.dart';

class StoreRepository {
  static FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  static FirebaseFirestore firestore = FirebaseFirestore.instance;
  static CollectionReference users = firestore.collection('users');
  static CollectionReference stores = firestore.collection('stores');

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

  static Future<void> updateStore(Store store) async {
    try {
      await stores.doc(store.id).update({
        'address': store.address,
        'bukalapak_name': store.bukalapakName,
        'city': store.city,
        'description': store.description,
        'facebook_acc': store.facebookAcc,
        'instagram_acc': store.instagramAcc,
        'phone_number': store.phoneNumber,
        'province': store.province,
        'shoope_name': store.shopeeName,
        'tag': store.tags,
        'tokopedia_name': store.tokopediaName,
        'youtube_link': store.youtubeLink,
        'umkm_name': store.name,
      });
    } catch (e) {
      print(e.toString());
    }
  }

  static Future<void> addProduct(String uid, String name, String description,
      File image, int price) async {
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
      await stores.doc(uid).collection("products").add({
        'name': name.toUpperCase(),
        'description': description,
        'image': urlDownload,
        'price': price
      });
    } catch (e) {
      print(e.toString());
    }
  }

  static Future<void> deleteProduct(String uid, String productid) async {
    try {
      await stores.doc(uid).collection('products').doc(productid).delete();
    } catch (e) {
      print(e);
    }
  }

  static Future<void> updateProduct(String uid, String productid, String name,
      String description, File image, int price, String imageLink) async {
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

      await stores.doc(uid).collection("products").doc(productid).update({
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
