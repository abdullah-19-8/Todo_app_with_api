// ignore: depend_on_referenced_packages
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter/material.dart';

class ThemeController with ChangeNotifier {
  bool _isDarkMode = false;

  bool get isDarkMode => _isDarkMode;

  void changeTheme() async {
    _isDarkMode = !_isDarkMode;
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setBool('isDarkMode', _isDarkMode);
    notifyListeners();
  }

  void assignTheme() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    if (pref.getBool('isDarkMode') != null) {
      _isDarkMode = pref.getBool('isDarkMode')!;
    } else {
      _isDarkMode = false;
    }
    notifyListeners();
  }
}
