import 'package:shared_preferences/shared_preferences.dart';

class PrefRepository{
  static Future<SharedPreferences> prefs = SharedPreferences.getInstance();

  static Future<String?> getUserID(){
    return prefs.then((SharedPreferences prefs){
      return prefs.getString("userid");
    });
  }

  static Future<String?> getRole(){
    return prefs.then((SharedPreferences prefs){
      return prefs.getString("role");
    });
  }

  
}