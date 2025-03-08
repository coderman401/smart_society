import 'package:flutter/material.dart';

class AppTheme {
  static const MaterialColor primary =
      MaterialColor(_primaryValue, <int, Color>{
    50: Color(0xFFE7FAFA),
    100: Color(0xFFC2F3F2),
    200: Color(0xFF99ECEA),
    300: Color(0xFF70E4E2),
    400: Color(0xFF52DEDB),
    500: Color(_primaryValue),
    600: Color(0xFF2ED4D0),
    700: Color(0xFF27CECA),
    800: Color(0xFF20C8C4),
    900: Color(0xFF14BFBA),
  });
  static const int _primaryValue = 0xFF8C57FF;

  static const MaterialColor primaryAccent =
      MaterialColor(_primaryAccentValue, <int, Color>{
    100: Color(0xFFF0FFFF),
    200: Color(_primaryAccentValue),
    400: Color(0xFF8AFFFC),
    700: Color(0xFF70FFFB),
  });
  static const int _primaryAccentValue = 0xFFBDFFFD;

  static const MaterialColor secondary =
      MaterialColor(_secondaryValue, <int, Color>{
    50: Color(0xFFFFFDF0),
    100: Color(0xFFFFFBDA),
    200: Color(0xFFFFF8C2),
    300: Color(0xFFFFF5AA),
    400: Color(0xFFFFF397),
    500: Color(_secondaryValue),
    600: Color(0xFFFFEF7D),
    700: Color(0xFFFFED72),
    800: Color(0xFFFFEB68),
    900: Color(0xFFFFE755),
  });
  static const int _secondaryValue = 0xFFFFF185;

  static const MaterialColor secondaryAccent =
      MaterialColor(_secondaryAccentValue, <int, Color>{
    100: Color(0xFFFFFFFF),
    200: Color(_secondaryAccentValue),
    400: Color(0xFFFFFEFA),
    700: Color(0xFFFFFAE0),
  });
  static const int _secondaryAccentValue = 0xFFFFFFFF;

  static const TextStyle titleStyle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
  );
  static const TextStyle subTitleStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w500,
  );

  static const Color backgroundPaperLight = Color(0xFFffffff);
  static const Color backgroundPaperDark = Color(0xFF312D4B);
}
