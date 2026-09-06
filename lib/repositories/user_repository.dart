import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../models/user_model.dart';
import '../services/app_logger.dart';
import 'auth_result.dart';

class UserRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final db = FirebaseDatabase.instance.ref();

  String _emailKey(String email) =>
      email.trim().toLowerCase().replaceAll('.', ',');

  /// Maps a Firebase error code to a user-facing message.
  String _messageForAuthCode(String code) {
    switch (code) {
      case 'email-already-in-use':
        return 'An account already exists for that email.';
      case 'invalid-email':
        return 'That email address is not valid.';
      case 'weak-password':
        return 'That password is too weak. Use at least 6 characters.';
      case 'wrong-password':
      case 'invalid-credential':
        return 'Incorrect email or password.';
      case 'user-not-found':
        return 'No account found for that email.';
      case 'user-disabled':
        return 'This account has been disabled.';
      case 'too-many-requests':
        return 'Too many attempts. Please try again later.';
      case 'network-request-failed':
        return 'Network error. Check your connection and try again.';
      default:
        return 'Something went wrong. Please try again.';
    }
  }

  Future<AuthResult> createUser({
    required String email,
    required String phone,
    required String country,
    required String userType,
    required String password,
  }) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Save additional user info to Firebase Realtime Database
      await saveUserData(
        email: email,
        phone: phone,
        country: country,
        userType: userType,
      );

      return const AuthResult.success();
    } on FirebaseAuthException catch (e) {
      return AuthResult.failure(e.code, _messageForAuthCode(e.code));
    } catch (e) {
      AppLogger.error('createUser failed', e);
      return AuthResult.failure('unknown', _messageForAuthCode('unknown'));
    }
  }

  Future<AuthResult> signIn({
    required String email,
    required String password,
  }) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return const AuthResult.success();
    } on FirebaseAuthException catch (e) {
      return AuthResult.failure(e.code, _messageForAuthCode(e.code));
    } catch (e) {
      AppLogger.error('signIn failed', e);
      return AuthResult.failure('unknown', _messageForAuthCode('unknown'));
    }
  }

  Future<AuthResult> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        return AuthResult.failure('cancelled', 'Sign-in was cancelled.');
      }
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final userCredential = await _firebaseAuth.signInWithCredential(
        credential,
      );

      // First-time Google sign-in: mirror the signup flow and create the
      // user's Realtime Database record, since other screens (profile,
      // etc.) key off users/{email} and assume it exists.
      final email = userCredential.user?.email;
      if (userCredential.additionalUserInfo?.isNewUser == true &&
          email != null) {
        await saveUserData(
          email: email,
          phone: '',
          country: '',
          userType: 'google',
        );
      }

      return const AuthResult.success();
    } on FirebaseAuthException catch (e) {
      return AuthResult.failure(e.code, _messageForAuthCode(e.code));
    } catch (e) {
      AppLogger.error('signInWithGoogle failed', e);
      return AuthResult.failure('unknown', _messageForAuthCode('unknown'));
    }
  }

  /// Get current authenticated user
  User? get currentUser => _firebaseAuth.currentUser;

  /// Test Firebase Database connection
  Future<bool> testDatabaseConnection() async {
    try {
      final User? user = _firebaseAuth.currentUser;
      if (user == null) {
        AppLogger.log('Test: No authenticated user');
        return false;
      }

      AppLogger.log('Test: User authenticated: ${user.email}');

      // Try to read a simple value
      final DatabaseReference testRef = db.child('test');
      await testRef.set({'timestamp': DateTime.now().millisecondsSinceEpoch});
      AppLogger.log('Test: Write successful');

      final DataSnapshot snapshot = await testRef.get();
      AppLogger.log('Test: Read successful, data exists: ${snapshot.exists}');

      // Clean up test data
      await testRef.remove();
      AppLogger.log('Test: Database connection successful');
      return true;
    } catch (e) {
      AppLogger.error('Test: Database connection failed', e);
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
      AppLogger.error('Error fetching user data', e);
      return null;
    }
  }

  /// Update user data in Firebase Realtime Database
  Future<bool> updateUserData(UserModel userModel) async {
    try {
      final User? user = _firebaseAuth.currentUser;
      if (user == null) {
        AppLogger.log('Error: No authenticated user found');
        return false;
      }

      final String key = _emailKey(user.email ?? '');
      AppLogger.log('Updating user data for key: $key');

      await db.child('users').child(key).update(userModel.toMap());
      AppLogger.log('User data updated successfully');
      return true;
    } catch (e) {
      AppLogger.error('Error updating user data', e);
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
      AppLogger.error('Error saving user data', e);
      return false;
    }
  }
}
