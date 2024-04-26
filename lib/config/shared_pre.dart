import 'dart:ffi';

import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  static SharedPreferencesService? _instance;
  late SharedPreferences _prefs;

  SharedPreferencesService._(); // private constructor

  factory SharedPreferencesService.getInstance() {
    if (_instance == null) {
      _instance = SharedPreferencesService._();
    }
    return _instance!;
  }

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }


  String getString(String key, {String defaultValue = ''}) {
    return _prefs.getString(key) ?? defaultValue;
  }


  int getInt(String key, {int defaultValue = 0}) {
    return _prefs.getInt(key) ?? defaultValue;
  }

  Future<void> setInt(String key, int value) async {
    await _prefs.setInt(key, value);
  }
}