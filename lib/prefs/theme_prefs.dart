import 'package:shared_preferences/shared_preferences.dart';

class ThemePrefs {

  static const String themeKey = "themeKey";

  setTheme(bool val) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(themeKey, val);
  }

  getTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.getBool(themeKey);
  }

}