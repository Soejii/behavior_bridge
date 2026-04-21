import 'package:flutter/material.dart';

class AppColors {
  // neutrals
  static const Color ink = Color(0xFF0E1420);
  static const Color ink2 = Color(0xFF32405A);
  static const Color ink3 = Color(0xFF5F6B82);
  static const Color ink4 = Color(0xFF8A94A8);
  static const Color line = Color(0xFFE5E9F0);
  static const Color line2 = Color(0xFFEEF1F6);
  static const Color bg = Color(0xFFF6F7FB);
  static const Color bgDeep = Color(0xFFEDEFF5);
  static const Color card = Color(0xFFFFFFFF);

  // accent (indigo preset)
  static const Color accent = Color(0xFF3A5FCD);
  static const Color accentTint = Color(0xFFEEF1FB);
  static const Color accentTintDeep = Color(0xFFDDE3F5);
  static const Color accentFg = Color(0xFF2B47A0);

  // semantic
  static const Color ok = Color(0xFF2F9E6E);
  static const Color okTint = Color(0xFFE3F4EB);
  static const Color okDark = Color(0xFF1E6A49);
  static const Color warn = Color(0xFFC98A1E);
  static const Color warnTint = Color(0xFFFBF1DC);
  static const Color warnDark = Color(0xFF7A5210);
  static const Color risk = Color(0xFFC0432E);
  static const Color riskTint = Color(0xFFF8E2DC);

  // shadows
  static const List<BoxShadow> sh1 = [
    BoxShadow(
      color: Color.fromRGBO(14, 20, 32, 0.04),
      offset: Offset(0, 1),
      blurRadius: 2,
    ),
    BoxShadow(
      color: Color.fromRGBO(14, 20, 32, 0.03),
      offset: Offset(0, 1),
      blurRadius: 1,
    ),
  ];

  static const List<BoxShadow> sh2 = [
    BoxShadow(
      color: Color.fromRGBO(14, 20, 32, 0.06),
      offset: Offset(0, 1),
      blurRadius: 3,
    ),
    BoxShadow(
      color: Color.fromRGBO(14, 20, 32, 0.05),
      offset: Offset(0, 8),
      blurRadius: 24,
    ),
  ];
}

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF$hexColor';
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}
