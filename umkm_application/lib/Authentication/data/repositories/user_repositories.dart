import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserRepository {
  static FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  static FirebaseFirestore firestore = FirebaseFirestore.instance;
  static CollectionReference users = firestore.collection('users');
  // Sign Up with email and password

  static Future<User?> signUp(String email, String password, String umkmName) async {
    try {
      var auth = await firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      await users.doc(auth.user!.uid).set({
        'address' : '',
        'bukalapak_name' : '',
        'city' : '',
        'description' : '',
        'uid' : auth.user!.uid,
        'email': auth.user!.email,
        'facebook_acc' : '',
        'image' : '',
        'instagram_acc' : '',
        'phone_number' : '',
        'province' : '',
        'shoope_name' : '',
        'tag' : [],
        'tokopedia_name' : '',
        'youtube_link' : '',
        'umkm_name' : umkmName,
        'role' : 'store'
      });
      return auth.user;
    } catch (e) {
      print(e.toString());
    }
  }

  // Sign In with email and password

  static Future<User?> signIn(String email, String password) async {
    try {
      var auth = await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return auth.user;
    } catch (e) {
      print(e.toString());
    }
  }

  // Sign Out

  static Future<void> signOut() async {
    await firebaseAuth.signOut();
  }

  // check Sign In
  static Future<bool> isSignedIn() async {
    // ignore: await_only_futures
    var currentUser = await firebaseAuth.currentUser;
    return currentUser != null;
  }

  //get current user

  static Future<User?> getCurrentUser() async {
    // ignore: await_only_futures
    return await firebaseAuth.currentUser;
  }
}