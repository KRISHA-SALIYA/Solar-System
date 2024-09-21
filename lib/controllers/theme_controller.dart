import 'package:flutter/material.dart';

import '../prefs/theme_prefs.dart';



class ThemeController extends ChangeNotifier {
  late bool _isLight;
  late ThemePrefs _prefs;

  bool get isLight => _isLight;

  ThemeController() {
    _isLight = false;
    _prefs = ThemePrefs();
    getPrefs();
  }

  set isLight(bool val) {
    _isLight = val;
    _prefs.setTheme(val);
    notifyListeners();
  }

  getPrefs() async {
    _isLight = await _prefs.getTheme();
    notifyListeners();
  }
}
