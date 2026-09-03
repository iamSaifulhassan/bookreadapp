import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'app_logger.dart';

class FirebaseStorageService {
  static final FirebaseStorage _storage = FirebaseStorage.instance;
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  /// Per-user folder so a client only ever addresses its own files.
  /// Pair with a Storage rule restricting reads/writes to
  /// `request.auth.uid == userId` on `profile_images/{userId}/**`.
  static Reference _userFolder(String uid) =>
      _storage.ref().child('profile_images').child(uid);

  /// Upload profile image to Firebase Storage
  /// Returns the download URL of the uploaded image
  static Future<String?> uploadProfileImage(File imageFile) async {
    try {
      final User? user = _auth.currentUser;
      if (user == null) {
        AppLogger.log('FirebaseStorage: User not authenticated');
        throw Exception('User not authenticated');
      }

      final String fileName = '${DateTime.now().millisecondsSinceEpoch}.jpg';
      final Reference ref = _userFolder(user.uid).child(fileName);

      final UploadTask uploadTask = ref.putFile(
        imageFile,
        SettableMetadata(contentType: 'image/jpeg'),
      );

      final TaskSnapshot snapshot = await uploadTask;
      final String downloadUrl = await snapshot.ref.getDownloadURL();
      AppLogger.log('FirebaseStorage: Upload complete: $downloadUrl');

      return downloadUrl;
    } catch (e) {
      AppLogger.error('Error uploading profile image', e);
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
      AppLogger.error('Error deleting profile image', e);
      return false;
    }
  }

  /// Get the current user's most recent profile image URL.
  ///
  /// Only lists within the current user's own folder (filenames are
  /// millisecond timestamps, so the lexicographically-largest name is the
  /// most recent upload) — never scans other users' files.
  static Future<String?> getProfileImageUrl() async {
    try {
      final User? user = _auth.currentUser;
      if (user == null) {
        AppLogger.log('FirebaseStorage: No authenticated user found');
        return null;
      }

      final ListResult result = await _userFolder(user.uid).listAll();
      if (result.items.isEmpty) {
        return null;
      }

      final Reference latest = result.items.reduce(
        (a, b) => a.name.compareTo(b.name) > 0 ? a : b,
      );
      return await latest.getDownloadURL();
    } catch (e) {
      if (e.toString().contains('object-not-found')) {
        return null;
      }
      AppLogger.error('Error getting profile image URL', e);
      return null;
    }
  }
}
