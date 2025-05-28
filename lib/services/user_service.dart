import 'package:firebase_auth/firebase_auth.dart';
import '../repositories/user_repository.dart';
import '../models/user_model.dart';
import 'profile_image_utils.dart';

class UserService {
  static final UserService _instance = UserService._internal();
  factory UserService() => _instance;
  UserService._internal();

  final UserRepository _userRepository = UserRepository();

  /// Get current authenticated user
  User? get currentUser => _userRepository.currentUser;

  /// Check if user is authenticated
  bool get isAuthenticated => currentUser != null;

  /// Fetch current user's profile data from Firebase
  Future<UserModel?> getCurrentUserProfile() async {
    try {
      return await _userRepository.getCurrentUserData();
    } catch (e) {
      print('Error fetching user profile: $e');
      return null;
    }
  }

  /// Update user profile data
  Future<bool> updateUserProfile(UserModel userModel) async {
    try {
      print('UserService: Updating profile for user: ${userModel.email}');
      final result = await _userRepository.updateUserData(userModel);
      print('UserService: Update result: $result');
      return result;
    } catch (e) {
      print('Error updating user profile: $e');
      return false;
    }
  }

  /// Get user's email from Firebase Auth
  String? get userEmail => currentUser?.email;

  /// Get user's display name from Firebase Auth
  String? get userDisplayName => currentUser?.displayName;

  /// Get user's UID
  String? get userUid => currentUser?.uid;

  /// Sign out the current user
  Future<void> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      print('Error signing out: $e');
    }
  }

  /// Get user's display name or extract name from email
  String? getUserDisplayName() {
    final user = currentUser;
    if (user?.displayName != null && user!.displayName!.isNotEmpty) {
      return user.displayName;
    }

    // Try to extract name from email
    if (user?.email != null) {
      final emailPart = user!.email!.split('@')[0];
      // Convert camelCase or snake_case to readable name
      final name = emailPart
          .replaceAll(RegExp(r'[_.]'), ' ')
          .replaceAllMapped(
            RegExp(r'([a-z])([A-Z])'),
            (match) => '${match.group(1)} ${match.group(2)}',
          )
          .split(' ')
          .map(
            (word) =>
                word.isEmpty
                    ? ''
                    : word[0].toUpperCase() + word.substring(1).toLowerCase(),
          )
          .join(' ');
      return name.trim().isNotEmpty ? name : null;
    }

    return null;
  }

  /// Get user initials for profile avatar
  String getUserInitials() {
    return ProfileImageUtils.generateInitials(getUserDisplayName(), userEmail);
  }

  /// Check if user profile is incomplete
  bool isProfileIncomplete(UserModel? userModel) {
    if (userModel == null) return true;
    return ProfileImageUtils.isProfileIncomplete(
      userModel.country,
      userModel.userType,
      userModel.phone,
    );
  }

  /// Get profile completion message
  String getProfileCompletionMessage(UserModel? userModel) {
    if (userModel == null) {
      return 'Please complete your profile by adding your information.';
    }
    return ProfileImageUtils.getProfileCompletionMessage(
      userModel.country,
      userModel.userType,
      userModel.phone,
    );
  }
}
