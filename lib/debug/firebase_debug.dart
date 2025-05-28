import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import '../repositories/user_repository.dart';
import '../services/user_service.dart';
import '../models/user_model.dart';

class FirebaseDebug {
  static final UserRepository _userRepository = UserRepository();
  static final UserService _userService = UserService();

  /// Test complete Firebase functionality
  static Future<void> runCompleteTest() async {
    print('\n=== FIREBASE DEBUG TEST START ===');

    // 1. Check authentication
    await _testAuthentication();

    // 2. Test database connection
    await _testDatabaseConnection();

    // 3. Test user data operations
    await _testUserOperations();

    print('=== FIREBASE DEBUG TEST END ===\n');
  }

  static Future<void> _testAuthentication() async {
    print('\n--- Testing Authentication ---');
    try {
      final User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        print('✅ User authenticated: ${user.email}');
        print('   UID: ${user.uid}');
        print('   Email verified: ${user.emailVerified}');
      } else {
        print('❌ No authenticated user');
      }
    } catch (e) {
      print('❌ Authentication error: $e');
    }
  }

  static Future<void> _testDatabaseConnection() async {
    print('\n--- Testing Database Connection ---');
    try {
      final bool isConnected = await _userRepository.testDatabaseConnection();
      if (isConnected) {
        print('✅ Database connection successful');
      } else {
        print('❌ Database connection failed');
      }
    } catch (e) {
      print('❌ Database connection error: $e');
    }
  }

  static Future<void> _testUserOperations() async {
    print('\n--- Testing User Operations ---');
    try {
      // Test reading current user data
      final UserModel? currentUser = await _userService.getCurrentUserProfile();
      if (currentUser != null) {
        print('✅ Current user data loaded:');
        print('   Email: ${currentUser.email}');
        print('   Phone: ${currentUser.phone}');
        print('   Country: ${currentUser.country}');
        print('   UserType: ${currentUser.userType}');
        print('   ProfileImageUrl: ${currentUser.profileImageUrl}');

        // Test updating user data
        print('\n--- Testing User Update ---');
        final updatedUser = currentUser.copyWith(
          phone:
              '${currentUser.phone}_test_${DateTime.now().millisecondsSinceEpoch}',
        );

        final bool updateSuccess = await _userService.updateUserProfile(
          updatedUser,
        );
        if (updateSuccess) {
          print('✅ User update successful');

          // Verify the update
          final UserModel? verifyUser =
              await _userService.getCurrentUserProfile();
          if (verifyUser != null && verifyUser.phone == updatedUser.phone) {
            print('✅ Update verification successful');

            // Restore original data
            final bool restoreSuccess = await _userService.updateUserProfile(
              currentUser,
            );
            if (restoreSuccess) {
              print('✅ Data restored successfully');
            } else {
              print('⚠️ Failed to restore original data');
            }
          } else {
            print('❌ Update verification failed');
          }
        } else {
          print('❌ User update failed');
        }
      } else {
        print('❌ No current user data found');
      }
    } catch (e) {
      print('❌ User operations error: $e');
    }
  }

  /// Test Firebase database rules
  static Future<void> testDatabaseRules() async {
    print('\n--- Testing Database Rules ---');
    try {
      final User? user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        print('❌ No authenticated user for rules test');
        return;
      }

      final DatabaseReference testRef = FirebaseDatabase.instance.ref().child(
        'test_rules',
      );

      // Test write permission
      try {
        await testRef.set({
          'test': 'write_test',
          'timestamp': DateTime.now().millisecondsSinceEpoch,
        });
        print('✅ Write permission granted');

        // Test read permission
        final DataSnapshot snapshot = await testRef.get();
        if (snapshot.exists) {
          print('✅ Read permission granted');
        } else {
          print('⚠️ Data not found after write');
        }

        // Clean up
        await testRef.remove();
        print('✅ Delete permission granted');
      } catch (e) {
        print('❌ Database rules error: $e');
        if (e.toString().contains('permission')) {
          print('   This appears to be a database rules issue');
          print('   Check your Firebase Realtime Database rules');
        }
      }
    } catch (e) {
      print('❌ Rules test error: $e');
    }
  }

  /// Check Firebase configuration
  static Future<void> checkFirebaseConfig() async {
    print('\n--- Checking Firebase Configuration ---');
    try {
      final User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        print('✅ Firebase Auth configured');
      }

      final DatabaseReference dbRef = FirebaseDatabase.instance.ref();
      print('✅ Firebase Database configured');
      print('   Database URL: ${dbRef.root.toString()}');
    } catch (e) {
      print('❌ Firebase configuration error: $e');
    }
  }
}
