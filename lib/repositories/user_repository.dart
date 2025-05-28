import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import '../models/user_model.dart';

class UserRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final db = FirebaseDatabase.instance.ref();

  String _emailKey(String email) =>
      email.trim().toLowerCase().replaceAll('.', ',');

  Future<bool> isEmailUnique(String email) async {
    // Firebase does not provide direct email uniqueness check, so try to fetch sign-in methods
    final methods = await _firebaseAuth.fetchSignInMethodsForEmail(email);
    return methods.isEmpty;
  }

  Future<bool> createUser({
    required String email,
    required String phone,
    required String country,
    required String userType,
    String? password,
  }) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password ?? 'changeme123', // Require password in UI
      );

      // Save additional user info to Firebase Realtime Database
      await saveUserData(
        email: email,
        phone: phone,
        country: country,
        userType: userType,
      );

      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        throw Exception('email-already-exists');
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  Future<bool> signIn({required String email, required String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) return false;
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      await _firebaseAuth.signInWithCredential(credential);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> signInWithFacebook() async {
    try {
      final LoginResult result = await FacebookAuth.instance.login();
      if (result.status == LoginStatus.success) {
        final OAuthCredential facebookAuthCredential =
            FacebookAuthProvider.credential(result.accessToken!.token);
        await _firebaseAuth.signInWithCredential(facebookAuthCredential);
        return true;
      } else {
        print(
          'Facebook login failed: \\nStatus: \\${result.status}\\nMessage: \\${result.message}',
        );
      }
      return false;
    } catch (e, stack) {
      print('Facebook sign-in error: $e');
      print(stack);
      return false;
    }
  }

  /// Get current authenticated user
  User? get currentUser => _firebaseAuth.currentUser;

  /// Test Firebase Database connection
  Future<bool> testDatabaseConnection() async {
    try {
      final User? user = _firebaseAuth.currentUser;
      if (user == null) {
        print('Test: No authenticated user');
        return false;
      }

      print('Test: User authenticated: ${user.email}');

      // Try to read a simple value
      final DatabaseReference testRef = db.child('test');
      await testRef.set({'timestamp': DateTime.now().millisecondsSinceEpoch});
      print('Test: Write successful');

      final DataSnapshot snapshot = await testRef.get();
      print('Test: Read successful, data exists: ${snapshot.exists}');

      // Clean up test data
      await testRef.remove();
      print('Test: Database connection successful');
      return true;
    } catch (e) {
      print('Test: Database connection failed: $e');
      return false;
    }
  }

  /// Fetch current user data from Firebase Realtime Database
  Future<UserModel?> getCurrentUserData() async {
    try {
      final User? user = _firebaseAuth.currentUser;
      if (user == null) return null;

      final String key = _emailKey(user.email ?? '');
      final DataSnapshot snapshot = await db.child('users').child(key).get();

      if (snapshot.exists) {
        final Map<String, dynamic> data = Map<String, dynamic>.from(
          snapshot.value as Map,
        );
        return UserModel.fromMap(data);
      }
      return null;
    } catch (e) {
      print('Error fetching user data: $e');
      return null;
    }
  }

  /// Update user data in Firebase Realtime Database
  Future<bool> updateUserData(UserModel userModel) async {
    try {
      final User? user = _firebaseAuth.currentUser;
      if (user == null) {
        print('Error: No authenticated user found');
        return false;
      }

      final String key = _emailKey(user.email ?? '');
      print('Updating user data for key: $key');
      print('User data: ${userModel.toMap()}');

      await db.child('users').child(key).update(userModel.toMap());
      print('User data updated successfully');
      return true;
    } catch (e) {
      print('Error updating user data: $e');
      return false;
    }
  }

  /// Save user data during signup
  Future<bool> saveUserData({
    required String email,
    required String phone,
    required String country,
    required String userType,
  }) async {
    try {
      final String key = _emailKey(email);
      final userRef = db.child('users').child(key);

      await userRef.set({
        'email': email,
        'phone': phone,
        'country': country,
        'userType': userType,
      });

      return true;
    } catch (e) {
      print('Error saving user data: $e');
      return false;
    }
  }
}
