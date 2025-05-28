import 'package:flutter/material.dart';

class AppColors {
  // Primary brand colors
  static const Color primary = Color(0xFF0A1931); // Navy blue
  static const Color onPrimary = Colors.white; // Text/icons on primary

  // Background and surface colors
  static const Color backgroundLight = Colors.white;
  static const Color backgroundDark = Colors.black;
  static const Color surface = Colors.white;
  static const Color onSurface =
      Colors.black87; // Slightly lighter than black for cards, etc.

  // Input and border colors
  static const Color inputFill = Color(
    0xFFF3F6FA,
  ); // Very light blue/grey for input fields
  static const Color border = Color(
    0x220A1931,
  ); // Navy with low opacity for subtle borders

  // Accent colors
  static const Color secondary = Color(
    0xFF185ADB,
  ); // Lighter blue for accents (optional)
  static const Color onSecondary = Colors.white; // Text/icons on secondary

  // Error colors
  static const Color error = Colors.redAccent;
  static const Color onError = Colors.white; // Text/icons on error
  // Text colors
  static const Color textPrimary = Color(
    0xFF212121,
  ); // Dark grey for primary text
  static const Color textSecondary = Color(
    0xFF757575,
  ); // Medium grey for secondary text
  static const Color textDisabled = Color(
    0xFFBDBDBD,
  ); // Light grey for disabled text

  // Success colors
  static const Color success = Color(0xFF4CAF50); // Green for success
  static const Color onSuccess = Color(0xFFFFFFFF); // White text on success
}
