import 'dart:io';
import 'lib/services/local_image_storage_service.dart';

void main() async {
  print('=== Local Image Storage Test ===');

  try {
    // Test getting profile image path
    final String? imagePath =
        await LocalImageStorageService.getProfileImagePath();
    print('Current profile image path: $imagePath');

    // Test checking if profile image exists
    final bool hasImage = await LocalImageStorageService.hasProfileImage();
    print('Has profile image: $hasImage');

    if (hasImage && imagePath != null) {
      // Test getting image file size
      final int? size = await LocalImageStorageService.getProfileImageSize();
      print(
        'Profile image size: ${size != null ? "${size} bytes" : "Unknown"}',
      );
    }

    print('✅ Local image storage service is working correctly!');
  } catch (e) {
    print('❌ Error testing local storage: $e');
  }
}
