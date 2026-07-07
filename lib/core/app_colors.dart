import 'package:flutter/material.dart';

abstract final class AppColors {
  AppColors._();

  static const Color background = Color(0xFF111315);
  static const Color surface = Color(0xFF181B1F);
  static const Color surfaceElevated = Color(0xFF20242A);
  static const Color panel = Color(0xFF242A31);
  static const Color panelMuted = Color(0xFF1E2329);

  static const Color primary = Color(0xFFE6B85C);
  static const Color primaryHover = Color(0xFFF0C977);
  static const Color primaryPressed = Color(0xFFC99940);
  static const Color primaryDark = Color(0xFF9E7831);

  static const Color secondary = Color(0xFF30C0A6);
  static const Color secondaryDark = Color(0xFF168B78);
  static const Color accent = Color(0xFFF1B85A);

  static const Color textPrimary = Color(0xFFF5F7FA);
  static const Color textSecondary = Color(0xFFC2CAD3);
  static const Color textMuted = Color(0xFF8D98A5);
  static const Color textDisabled = Color(0xFF65707C);

  static const Color border = Color(0xFF3A414A);
  static const Color borderSubtle = Color(0xFF2C3239);
  static const Color divider = Color(0xFF303740);
  static const Color focusRing = Color(0xFF9ECBFF);

  static const Color success = Color(0xFF39C980);
  static const Color warning = Color(0xFFE8A93C);
  static const Color error = Color(0xFFFF646D);
  static const Color info = Color(0xFF62C4FF);

  static const Color paper = Color(0xFFFFFFFF);
  static const Color paperTint = Color(0xFFF7F9FC);
  static const Color cutLine = Color(0xB3242A31);
  static const Color grid = Color(0x1F111315);
  static const Color shadow = Color(0x66000000);

  static const Color button = primary;
  static const Color buttonHover = primaryHover;
  static const Color buttonPressed = primaryPressed;
  static const Color buttonText = Color(0xFF171006);
}
