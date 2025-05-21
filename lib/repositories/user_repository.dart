import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

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
      // TODO: Save additional user info to Firestore/RTDB if needed
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
}
