import 'package:localstorage/localstorage.dart';

class Storage {
  static const jwt = "jwt";
  static const loginMethod = "loginMethod";
  static const refreshToken = "refreshToken";
  // Save a string value
  static Future<void> saveString(String key, String value) async {
      localStorage.setItem(key, value);
  }

  // Get a string value
  static Future<String?> getString(String key) async {
    return   localStorage.getItem(key);
  }

  // Remove a specific key
  static Future<void> remove(String key) async {
      localStorage.removeItem(key);
  }

  // Clear all data
  static Future<void> clearAll() async {
      localStorage.clear();
  }
}
