import 'package:permission_handler/permission_handler.dart';

import 'app_logger.dart';

/// Requests whatever storage permission the current Android version needs
/// to browse the user's book folder. Extracted out of home_screen.dart so
/// the screen doesn't own this platform-permission logic directly.
///
/// The platform permission dialogs/settings screens this calls should
/// always return promptly, but a lost activity-result callback (e.g. this
/// racing another activity-launching flow, like the Google Sign-In account
/// picker, that just returned) can otherwise strand the caller forever.
/// Every request is bounded so callers can fall back instead of hanging.
class StoragePermissionService {
  Future<PermissionStatus> _requestWithTimeout(Permission permission) {
    return permission.request().timeout(
      const Duration(seconds: 20),
      onTimeout: () => PermissionStatus.denied,
    );
  }

  Future<bool> requestStoragePermission() async {
    try {
      // For Android 11+ (API 30+), we need MANAGE_EXTERNAL_STORAGE
      if (await Permission.manageExternalStorage.isDenied) {
        final status = await _requestWithTimeout(
          Permission.manageExternalStorage,
        );
        if (status.isGranted) return true;
      }

      // For Android 13+ (API 33+), request media permissions
      if (await Permission.photos.isDenied) {
        await _requestWithTimeout(Permission.photos);
      }

      // Fallback to traditional storage permission
      final storageStatus = await _requestWithTimeout(Permission.storage);
      if (storageStatus.isGranted) return true;

      // Check if any permission is granted
      return await Permission.manageExternalStorage.isGranted ||
          await Permission.storage.isGranted ||
          await Permission.photos.isGranted;
    } catch (e) {
      AppLogger.log('Permission error: $e');
      // Fallback to basic storage permission
      final status = await _requestWithTimeout(Permission.storage);
      return status.isGranted;
    }
  }
}
