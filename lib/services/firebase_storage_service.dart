import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseStorageService {
  static final FirebaseStorage _storage = FirebaseStorage.instance;
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  /// Upload profile image to Firebase Storage
  /// Returns the download URL of the uploaded image
  static Future<String?> uploadProfileImage(File imageFile) async {
    try {
      final User? user = _auth.currentUser;
      if (user == null) {
        print('FirebaseStorage: User not authenticated');
        throw Exception('User not authenticated');
      }

      print('FirebaseStorage: Starting upload for user: ${user.uid}');

      // Create a unique filename using user ID and timestamp
      final String fileName =
          'profile_${user.uid}_${DateTime.now().millisecondsSinceEpoch}.jpg';

      print('FirebaseStorage: Upload filename: $fileName');

      // Create a reference to the location where we want to upload the image
      final Reference ref = _storage
          .ref()
          .child('profile_images')
          .child(fileName);

      print('FirebaseStorage: Upload reference: ${ref.fullPath}');

      // Upload the file
      final UploadTask uploadTask = ref.putFile(
        imageFile,
        SettableMetadata(
          contentType: 'image/jpeg',
          customMetadata: {
            'userId': user.uid,
            'uploadedAt': DateTime.now().toIso8601String(),
          },
        ),
      );

      // Wait for the upload to complete
      print('FirebaseStorage: Starting upload task...');
      final TaskSnapshot snapshot = await uploadTask;
      print('FirebaseStorage: Upload completed successfully');

      // Get the download URL
      final String downloadUrl = await snapshot.ref.getDownloadURL();
      print('FirebaseStorage: Download URL obtained: $downloadUrl');

      return downloadUrl;
    } catch (e) {
      print('Error uploading profile image: $e');
      return null;
    }
  }

  /// Delete profile image from Firebase Storage
  static Future<bool> deleteProfileImage(String imageUrl) async {
    try {
      final Reference ref = _storage.refFromURL(imageUrl);
      await ref.delete();
      return true;
    } catch (e) {
      print('Error deleting profile image: $e');
      return false;
    }
  }

  /// Get profile image URL for current user
  static Future<String?> getProfileImageUrl() async {
    try {
      final User? user = _auth.currentUser;
      if (user == null) {
        print('FirebaseStorage: No authenticated user found');
        return null;
      }

      print('FirebaseStorage: Getting profile image for user: ${user.uid}');

      // List files in the profile_images folder for the current user
      final ListResult result =
          await _storage.ref().child('profile_images').listAll();

      if (result.items.isEmpty) {
        print('FirebaseStorage: No profile images found in storage');
        return null;
      }

      // Find the most recent image for the current user
      String? latestImageUrl;
      int latestTimestamp = 0;

      for (final Reference ref in result.items) {
        try {
          final FullMetadata metadata = await ref.getMetadata();
          final String? userId = metadata.customMetadata?['userId'];
          final String? uploadedAt = metadata.customMetadata?['uploadedAt'];

          print(
            'FirebaseStorage: Checking file ${ref.name} - userId: $userId, uploadedAt: $uploadedAt',
          );

          if (userId == user.uid && uploadedAt != null) {
            final int timestamp =
                DateTime.parse(uploadedAt).millisecondsSinceEpoch;
            if (timestamp > latestTimestamp) {
              latestTimestamp = timestamp;
              latestImageUrl = await ref.getDownloadURL();
              print('FirebaseStorage: Found newer image: $latestImageUrl');
            }
          }
        } catch (metadataError) {
          print(
            'FirebaseStorage: Error reading metadata for ${ref.name}: $metadataError',
          );
          continue;
        }
      }

      print('FirebaseStorage: Final result: $latestImageUrl');
      return latestImageUrl;
    } catch (e) {
      // Handle the case where profile_images folder doesn't exist yet
      if (e.toString().contains('object-not-found')) {
        print(
          'FirebaseStorage: Profile images folder not found yet (no images uploaded)',
        );
        return null;
      }
      print('Error getting profile image URL: $e');
      return null;
    }
  }
}
