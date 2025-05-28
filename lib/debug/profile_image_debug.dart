import '../services/user_service.dart';
import '../services/firebase_storage_service.dart';
import '../models/user_model.dart';

/// Debug utility to test profile image flow
class ProfileImageDebug {
  static final UserService _userService = UserService();

  /// Test profile image loading and updating flow
  static Future<void> testProfileImageFlow() async {
    print('\n=== PROFILE IMAGE DEBUG TEST ===');

    try {
      // 1. Load current user profile
      print('\n1. Loading current user profile...');
      final UserModel? currentUser = await _userService.getCurrentUserProfile();
      if (currentUser != null) {
        print('✅ User profile loaded:');
        print('   - Email: ${currentUser.email}');
        print('   - ProfileImageUrl: ${currentUser.profileImageUrl}');
      } else {
        print('❌ Failed to load user profile');
        return;
      }

      // 2. Load profile image from storage
      print('\n2. Loading profile image from Firebase Storage...');
      final String? storageImageUrl =
          await FirebaseStorageService.getProfileImageUrl();
      print('   - Storage image URL: $storageImageUrl');

      // 3. Compare URLs
      print('\n3. Comparing image URLs:');
      print('   - Database URL: ${currentUser.profileImageUrl}');
      print('   - Storage URL: $storageImageUrl');
      print(
        '   - URLs match: ${currentUser.profileImageUrl == storageImageUrl}',
      );

      // 4. Test profile update with same data
      print('\n4. Testing profile update with same data...');
      final UserModel updatedUser = UserModel(
        email: currentUser.email,
        phone: currentUser.phone,
        country: currentUser.country,
        userType: currentUser.userType,
        profileImageUrl: currentUser.profileImageUrl,
      );

      final bool updateSuccess = await _userService.updateUserProfile(
        updatedUser,
      );
      print('   - Update success: $updateSuccess');

      if (updateSuccess) {
        // 5. Verify data persisted
        print('\n5. Verifying data persistence...');
        final UserModel? verifiedUser =
            await _userService.getCurrentUserProfile();
        if (verifiedUser != null) {
          print('✅ Data verified:');
          print('   - Email: ${verifiedUser.email}');
          print('   - ProfileImageUrl: ${verifiedUser.profileImageUrl}');
          print(
            '   - Image URL preserved: ${verifiedUser.profileImageUrl == currentUser.profileImageUrl}',
          );
        } else {
          print('❌ Failed to verify updated data');
        }
      }
    } catch (e) {
      print('❌ Error during profile image debug test: $e');
    }

    print('\n=== PROFILE IMAGE DEBUG TEST COMPLETE ===\n');
  }

  /// Test specific scenario: Edit profile without changing image
  static Future<void> testEditProfileWithoutImageChange() async {
    print('\n=== EDIT PROFILE WITHOUT IMAGE CHANGE TEST ===');

    try {
      // 1. Get current profile
      final UserModel? currentUser = await _userService.getCurrentUserProfile();
      if (currentUser == null) {
        print('❌ No current user found');
        return;
      }

      print('Initial state:');
      print('   - ProfileImageUrl: ${currentUser.profileImageUrl}');

      // 2. Simulate edit profile save without image change
      final String originalImageUrl = currentUser.profileImageUrl ?? '';

      // This simulates what EditProfileScreen does when saving
      final Map<String, String> editResult = {
        'email': currentUser.email,
        'phone': currentUser.phone,
        'country': currentUser.country,
        'userType': currentUser.userType,
        'profileImageUrl': originalImageUrl, // Same as original
      };

      print('\nSimulated edit result:');
      print('   - Returned profileImageUrl: ${editResult['profileImageUrl']}');

      // 3. Simulate profile screen update logic
      String? newProfileImageUrl = currentUser.profileImageUrl;
      final imageUrl = editResult['profileImageUrl'];
      if (imageUrl != null) {
        newProfileImageUrl = imageUrl.isEmpty ? null : imageUrl;
      }

      print('\nProfile screen update logic:');
      print('   - Original: ${currentUser.profileImageUrl}');
      print('   - Updated: $newProfileImageUrl');
      print(
        '   - Preserved: ${newProfileImageUrl == currentUser.profileImageUrl}',
      );
    } catch (e) {
      print('❌ Error during edit profile test: $e');
    }

    print('\n=== EDIT PROFILE WITHOUT IMAGE CHANGE TEST COMPLETE ===\n');
  }
}
