import 'package:shared_preferences/shared_preferences.dart';

class Prefs {
  static final Prefs _instance = Prefs.internal();
  factory Prefs() => _instance;
  Prefs.internal();

  static const JWT_TOKEN = 'Authorization';

  static SharedPreferences? _sharedPreferences;

  static Future<SharedPreferences> getInstance() async {
    if (_sharedPreferences == null) {
      _sharedPreferences = await SharedPreferences.getInstance();
    }
    return _sharedPreferences!;
  }

  Future<dynamic> get<Type>(String key) async {
    var instance = await getInstance();
    if (Type == bool) {
      return instance.getBool(key);
    } else if (Type == String) {
      return instance.getString(key);
    } else if (Type == int) {
      return instance.getInt(key);
    } else if (Type == double) {
      return instance.getDouble(key);
    } else {
      return instance.getString(key);
    }
  }

  Future<bool> set(String key, dynamic value) async {
    var instance = await getInstance();
    if (value is bool) {
      return instance.setBool(key, value);
    } else if (value is String) {
      return instance.setString(key, value);
    } else if (value is int) {
      return instance.setInt(key, value);
    } else if (value is double) {
      return instance.setDouble(key, value);
    }
    return false;
  }
}
