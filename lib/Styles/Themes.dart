import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Themes {

  Themes();

  RoundedRectangleBorder roundedBorder(double radius){
    return RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(radius)
    );
  }

  static const MaterialColor mainThemeColor = MaterialColor(_mainThemeColorPrimaryValue, <int, Color>{
    50: Color(0xFFFDF5EB),
    100: Color(0xFFFBE6CC),
    200: Color(0xFFF8D5AB),
    300: Color(0xFFF5C489),
    400: Color(0xFFF3B86F),
    500: Color(_mainThemeColorPrimaryValue),
    600: Color(0xFFEFA44F),
    700: Color(0xFFED9A45),
    800: Color(0xFFEB913C),
    900: Color(0xFFE7802B),
  });
  static const int _mainThemeColorPrimaryValue = 0xFFF1AB56;

  static const MaterialColor mainThemeColorAccent = MaterialColor(_mainThemeColorAccentValue, <int, Color>{
    100: Color(0xFFFFFFFF),
    200: Color(_mainThemeColorAccentValue),
    400: Color(0xFFFFDBC0),
    700: Color(0xFFFFCDA7),
  });
  static const int _mainThemeColorAccentValue = 0xFFFFF8F3;
}
