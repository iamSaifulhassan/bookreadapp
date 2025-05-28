import 'dart:io';
import 'package:path_provider/path_provider.dart';

class LocalImageStorageService {
  static const String _profileImagesFolderName = 'profile_images';
  static const String _profileImageFileName = 'profile_image.jpg';

  /// Get the profile images directory
  static Future<Directory> _getProfileImagesDirectory() async {
    final Directory appDocDir = await getApplicationDocumentsDirectory();
    final Directory profileImagesDir = Directory(
      '${appDocDir.path}/$_profileImagesFolderName',
    );

    // Create directory if it doesn't exist
    if (!await profileImagesDir.exists()) {
      await profileImagesDir.create(recursive: true);
    }

    return profileImagesDir;
  }

  /// Save profile image to local storage
  /// Returns the local file path if successful, null if failed
  static Future<String?> saveProfileImage(File imageFile) async {
    try {
      print('LocalImageStorage: Starting to save profile image locally...');

      final Directory profileImagesDir = await _getProfileImagesDirectory();
      final String newImagePath =
          '${profileImagesDir.path}/$_profileImageFileName';

      // Delete existing profile image if it exists
      final File existingImage = File(newImagePath);
      if (await existingImage.exists()) {
        await existingImage.delete();
        print('LocalImageStorage: Deleted existing profile image');
      }

      // Copy the new image to the profile images directory
      final File savedImage = await imageFile.copy(newImagePath);

      if (await savedImage.exists()) {
        print(
          'LocalImageStorage: Profile image saved successfully at: $newImagePath',
        );
        return newImagePath;
      } else {
        print('LocalImageStorage: Failed to save profile image');
        return null;
      }
    } catch (e) {
      print('LocalImageStorage: Error saving profile image: $e');
      return null;
    }
  }

  /// Get the current profile image file path
  /// Returns the file path if image exists, null if no image found
  static Future<String?> getProfileImagePath() async {
    try {
      final Directory profileImagesDir = await _getProfileImagesDirectory();
      final String imagePath =
          '${profileImagesDir.path}/$_profileImageFileName';
      final File imageFile = File(imagePath);

      if (await imageFile.exists()) {
        print('LocalImageStorage: Found profile image at: $imagePath');
        return imagePath;
      } else {
        print('LocalImageStorage: No profile image found');
        return null;
      }
    } catch (e) {
      print('LocalImageStorage: Error getting profile image path: $e');
      return null;
    }
  }

  /// Delete the current profile image
  /// Returns true if deleted successfully or no image existed, false if error
  static Future<bool> deleteProfileImage() async {
    try {
      final Directory profileImagesDir = await _getProfileImagesDirectory();
      final String imagePath =
          '${profileImagesDir.path}/$_profileImageFileName';
      final File imageFile = File(imagePath);

      if (await imageFile.exists()) {
        await imageFile.delete();
        print('LocalImageStorage: Profile image deleted successfully');
      } else {
        print('LocalImageStorage: No profile image to delete');
      }
      return true;
    } catch (e) {
      print('LocalImageStorage: Error deleting profile image: $e');
      return false;
    }
  }

  /// Check if a profile image exists
  static Future<bool> hasProfileImage() async {
    try {
      final String? imagePath = await getProfileImagePath();
      return imagePath != null;
    } catch (e) {
      print('LocalImageStorage: Error checking if profile image exists: $e');
      return false;
    }
  }

  /// Get the file size of the profile image in bytes
  static Future<int?> getProfileImageSize() async {
    try {
      final String? imagePath = await getProfileImagePath();
      if (imagePath != null) {
        final File imageFile = File(imagePath);
        final int size = await imageFile.length();
        print(
          'LocalImageStorage: Profile image size: ${(size / 1024 / 1024).toStringAsFixed(2)} MB',
        );
        return size;
      }
      return null;
    } catch (e) {
      print('LocalImageStorage: Error getting profile image size: $e');
      return null;
    }
  }
}
