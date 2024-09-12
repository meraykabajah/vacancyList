import 'package:shared_preferences/shared_preferences.dart';

class AppSharedPreferences {
  AppSharedPreferences._();

  static SharedPreferences? prefs;
  static init() async {
    prefs = await SharedPreferences.getInstance();
  }
}