import 'package:flutter/material.dart';

/// DigitalOcean-inspired color palette
/// Supports both light and dark themes
class AppColors {
  // Primary - DigitalOcean Blue
  static const Color primary = Color(0xFF0069FF);
  static const Color primaryDark = Color(0xFF0050D4);
  static const Color primaryLight = Color(0xFF338FFF);

  // Secondary - Accent colors
  static const Color success = Color(0xFF00C851);
  static const Color warning = Color(0xFFFFBB33);
  static const Color error = Color(0xFFFF3547);
  static const Color info = Color(0xFF33B5E5);

  // Neutrals - Light Theme
  static const Color white = Color(0xFFFFFFFF);
  static const Color gray50 = Color(0xFFF7FAFC);
  static const Color gray100 = Color(0xFFEDF2F7);
  static const Color gray200 = Color(0xFFE2E8F0);
  static const Color gray300 = Color(0xFFCBD5E0);
  static const Color gray400 = Color(0xFFA0AEC0);
  static const Color gray500 = Color(0xFF718096);
  static const Color gray600 = Color(0xFF4A5568);
  static const Color gray700 = Color(0xFF2D3748);
  static const Color gray800 = Color(0xFF1A202C);
  static const Color gray900 = Color(0xFF171923);

  // Dark Theme Specific
  static const Color dark50 = Color(0xFF1A202C);
  static const Color dark100 = Color(0xFF2D3748);
  static const Color dark200 = Color(0xFF4A5568);
  static const Color dark300 = Color(0xFF718096);

  // Context-aware colors (use with Theme.of(context).brightness)
  static Color textPrimary(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark ? white : gray900;
  }

  static Color textSecondary(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark ? gray300 : gray600;
  }

  static Color textDisabled(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark ? gray500 : gray400;
  }

  static Color background(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark ? dark50 : white;
  }

  static Color surface(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark ? dark100 : gray50;
  }

  static Color border(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark ? dark200 : gray300;
  }

  static Color divider(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark ? dark200 : gray200;
  }
}
