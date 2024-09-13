import 'package:flutter/material.dart';
import 'package:solve/themes/darktheme.dart';
import 'package:solve/themes/lighttheme.dart';

class Themeprov extends ChangeNotifier {
  ThemeData _themeData = lighttheme;
  ThemeData get themedata => _themeData;
  bool get isdark => _themeData == darktheme;

  set themedata(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
  }

  void toggletheme() {
    if (_themeData == lighttheme) {
      _themeData = darktheme;
    } else {
      _themeData = lighttheme;
    }
  }
}
