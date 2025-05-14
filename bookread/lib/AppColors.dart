import 'package:flutter/material.dart';

class AppColors {
  // Primary brand colors
  static const Color primary = Color(0xFF7C4DFF); // Lighter, vibrant purple
  static const Color onPrimary = Color(0xFFFFFFFF); // White text on primary
  static const Color secondary = Color(0xFF00B0FF); // Bright blue
  static const Color onSecondary = Color(0xFFFFFFFF); // White text on secondary

  // Background and surface colors
  static const Color backgroundLight = Color.fromARGB(
    255,
    255,
    255,
    255,
  ); // Off white, soft light background
  static const Color backgroundDark = Color(0xFF121212); // Dark mode background
  static const Color surface = Color(
    0xFFFFFFFF,
  ); // White surface for cards and buttons
  static const Color onSurface = Color(0xFF212121); // Dark text on surface

  // Text colors
  static const Color textPrimary = Color(
    0xFF212121,
  ); // Dark text for main content
  static const Color textSecondary = Color(
    0xFF757575,
  ); // Lighter gray text for secondary content
  static const Color textDisabled = Color(0xFFBDBDBD); // Disabled text (muted)

  // Error colors
  static const Color error = Color(0xFFD32F2F); // Red error color
  static const Color onError = Color(0xFFFFFFFF); // White text on error

  // Success/Accent colors
  static const Color success = Color(0xFF4CAF50); // Green for success
  static const Color onSuccess = Color(0xFFFFFFFF); // White text on success
}
