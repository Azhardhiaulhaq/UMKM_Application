import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:umkm_application/data/repositories/shared_pref_repositories.dart';

class UserRepository {
  static FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  static FirebaseFirestore firestore = FirebaseFirestore.instance;
  static CollectionReference users = firestore.collection('users');
  static CollectionReference statistics = firestore.collection('statistics');
  // Sign Up with email and password

  static Future<User?> signUp(
      String email, String password, String umkmName) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var auth = await firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      await users.doc(auth.user!.uid).set({
        'address': '',
        'bukalapak_name': '',
        'city': '',
        'description': '',
        'uid': auth.user!.uid,
        'email': auth.user!.email,
        'facebook_acc': '',
        'image': '',
        'instagram_acc': '',
        'phone_number': '',
        'province': '',
        'shoope_name': '',
        'tag': [],
        'tokopedia_name': '',
        'youtube_link': '',
        'umkm_name': umkmName.toUpperCase(),
        'role': 'store'
      });
      await statistics.doc(auth.user!.uid).set({
        'umkm_name': umkmName,
      });
      prefs.setString('userid', auth.user!.uid);
      prefs.setString('role', 'store');
      return auth.user;
    } catch (e) {
      print(e.toString());
    }
  }

  // Sign In with email and password

  static Future<User?> signIn(String email, String password) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var auth = await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);

      users.doc(auth.user!.uid).snapshots().listen((result) {
        var mapUser = result.data() as Map<String, dynamic>;
        sharedPrefs.setID(auth.user!.uid);
        sharedPrefs.setEmail(auth.user!.email!);
        sharedPrefs.setRole(mapUser['role'] ?? 'store');
        sharedPrefs.setIsMaster(mapUser['isMaster'] ?? false);
      });

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
     if (currentUser != null) {
      // ignore: await_only_futures
      await users.doc(currentUser.uid).snapshots().listen((result) {
        var mapUser = result.data() as Map<String, dynamic>;
        sharedPrefs.setName(mapUser['name']??'');
        sharedPrefs.setID(currentUser.uid);
        sharedPrefs.setRole(mapUser['role']??'store');
        sharedPrefs.setEmail(currentUser.email!);
      });
    }
    return currentUser != null;
  }

  //get current user

  static Future<User?> getCurrentUser() async {
    // ignore: await_only_futures
    return await firebaseAuth.currentUser;
  }

  static Future<bool> checkSameID(String id) async {
    // ignore: await_only_futures
    var currentUser = await firebaseAuth.currentUser;

    return currentUser!.uid == id;
  }
}
