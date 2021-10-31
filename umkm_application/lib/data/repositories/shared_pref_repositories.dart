import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static SharedPreferences? _sharedPrefs;

  init() async {
    if (_sharedPrefs == null) {
      _sharedPrefs = await SharedPreferences.getInstance();
    }
  }

  String get userid => _sharedPrefs!.getString('userid') ?? "";

  String get role => _sharedPrefs!.getString('role') ?? "";

  String get name => _sharedPrefs!.getString('name')?? "";

  String get email => _sharedPrefs!.getString('email') ?? "";

  bool get isMaster => _sharedPrefs!.getBool('isMaster') ?? false;

  void setIsMaster(bool isMaster){
    _sharedPrefs!.setBool('isMaster', isMaster);
  }
  void setName(String name){
    _sharedPrefs!.setString('name',name);
  }

  void setRole(String role){
    _sharedPrefs!.setString('role',role);
  }

  // ignore: non_constant_identifier_names
  void setID(String ID){
    _sharedPrefs!.setString('userid',ID);
  }

  void setEmail(String email){
    _sharedPrefs!.setString('email',email);
  }

  void remove() => _sharedPrefs!.clear();
  
}

final sharedPrefs = SharedPrefs();
