import 'package:flutter/material.dart';
import '../themes/AppColors.dart';

class ProfileImageUtils {
  /// Generate initials from user's name or email
  static String generateInitials(String? name, String? email) {
    // Try to get initials from display name first
    if (name != null && name.trim().isNotEmpty) {
      final nameParts = name.trim().split(' ');
      if (nameParts.length >= 2) {
        return '${nameParts[0][0]}${nameParts[1][0]}'.toUpperCase();
      } else if (nameParts.length == 1 && nameParts[0].length >= 2) {
        return nameParts[0].substring(0, 2).toUpperCase();
      }
    }

    // Fallback to email if name is not available
    if (email != null && email.trim().isNotEmpty) {
      final emailParts = email.split('@')[0]; // Get part before @
      if (emailParts.length >= 2) {
        return emailParts.substring(0, 2).toUpperCase();
      } else if (emailParts.length == 1) {
        return emailParts[0].toUpperCase();
      }
    }

    return 'U'; // Ultimate fallback
  }

  /// Create a circular avatar with initials
  static Widget createInitialsAvatar({
    required String initials,
    required double radius,
    Color? backgroundColor,
    Color? textColor,
    double? fontSize,
  }) {
    return CircleAvatar(
      radius: radius,
      backgroundColor: backgroundColor ?? AppColors.primary.withOpacity(0.8),
      child: Text(
        initials,
        style: TextStyle(
          fontSize: fontSize ?? radius * 0.5,
          fontWeight: FontWeight.bold,
          color: textColor ?? Colors.white,
        ),
      ),
    );
  }

  /// Create a profile avatar that handles both network images and initials
  static Widget createProfileAvatar({
    required String? imageUrl,
    required String? name,
    required String? email,
    required double radius,
    Color? backgroundColor,
    Color? textColor,
    VoidCallback? onTap,
    bool useAppIconFallback = false,
  }) {
    final initials = generateInitials(name, email);

    Widget avatar;
    if (imageUrl != null && imageUrl.isNotEmpty) {
      avatar = CircleAvatar(
        radius: radius,
        backgroundColor: backgroundColor ?? AppColors.primary.withOpacity(0.1),
        backgroundImage: NetworkImage(imageUrl),
        onBackgroundImageError: (exception, stackTrace) {
          // If image fails to load, show initials instead
          print('Failed to load profile image: $exception');
        },
        child:
            imageUrl.isEmpty
                ? _buildFallbackAvatar(
                  initials: initials,
                  radius: radius,
                  backgroundColor: backgroundColor,
                  textColor: textColor,
                  useAppIconFallback: useAppIconFallback,
                )
                : null,
      );
    } else {
      avatar = _buildFallbackAvatar(
        initials: initials,
        radius: radius,
        backgroundColor: backgroundColor,
        textColor: textColor,
        useAppIconFallback: useAppIconFallback,
      );
    }

    if (onTap != null) {
      return GestureDetector(onTap: onTap, child: avatar);
    }

    return avatar;
  }

  /// Build fallback avatar with initials or app icon
  static Widget _buildFallbackAvatar({
    required String initials,
    required double radius,
    Color? backgroundColor,
    Color? textColor,
    bool useAppIconFallback = false,
  }) {
    if (useAppIconFallback) {
      // Use app icon as fallback
      return CircleAvatar(
        radius: radius,
        backgroundColor: backgroundColor ?? AppColors.primary.withOpacity(0.1),
        child: ClipOval(
          child: Image.asset(
            'assets/images/App.png',
            width: radius * 1.5,
            height: radius * 1.5,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              // If app icon fails, fall back to initials
              return Text(
                initials,
                style: TextStyle(
                  fontSize: radius * 0.5,
                  fontWeight: FontWeight.bold,
                  color: textColor ?? Colors.white,
                ),
              );
            },
          ),
        ),
      );
    } else {
      // Use initials avatar
      return createInitialsAvatar(
        initials: initials,
        radius: radius,
        backgroundColor: backgroundColor,
        textColor: textColor,
      );
    }
  }

  /// Check if profile is incomplete (missing required fields)
  static bool isProfileIncomplete(
    String? country,
    String? userType,
    String? phone,
  ) {
    return (country == null || country.isEmpty || country == 'No country') ||
        (userType == null || userType.isEmpty || userType == 'No user type') ||
        (phone == null || phone.isEmpty || phone == 'No phone number');
  }

  /// Get completion message for incomplete profile
  static String getProfileCompletionMessage(
    String? country,
    String? userType,
    String? phone,
  ) {
    List<String> missing = [];

    if (country == null || country.isEmpty || country == 'No country') {
      missing.add('Country');
    }
    if (userType == null || userType.isEmpty || userType == 'No user type') {
      missing.add('User Type');
    }
    if (phone == null || phone.isEmpty || phone == 'No phone number') {
      missing.add('Phone Number');
    }

    if (missing.isEmpty) return '';

    if (missing.length == 1) {
      return 'Please complete your profile by adding your ${missing[0]}.';
    } else if (missing.length == 2) {
      return 'Please complete your profile by adding your ${missing[0]} and ${missing[1]}.';
    } else {
      return 'Please complete your profile by adding your ${missing.join(', ')}.';
    }
  }
}
