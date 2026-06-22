import 'package:flutter/material.dart';

class AppColors {
  static const background = Color(0xFF0B0F17);

  static const surface = Color(0xFF131A26);

  static const surface2 = Color(0xFF1A2233);

  static const primary = Color(0xFF5EA1FF);

  static const accent = Color(0xFF79B8FF);

  static const success = Color(0xFF34D399);

  static const text = Colors.white;

  static const secondaryText =
      Color(0xFF9CA3AF);

  static const border =
      Color.fromRGBO(255, 255, 255, .08);

  static const glass =
      Color.fromRGBO(255, 255, 255, .05);
}

class AppTheme {
  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor:
        AppColors.background,

    fontFamily: 'SF Pro Display',

    colorScheme: const ColorScheme.dark(
      primary: AppColors.primary,
    ),
  );
}