/// Outcome of an auth operation (sign-in, sign-up, Google sign-in).
///
/// Carries the underlying [errorCode] (typically a `FirebaseAuthException.code`)
/// so callers can distinguish failure reasons instead of a bare `bool`.
class AuthResult {
  final bool success;
  final String? errorCode;
  final String? message;

  const AuthResult.success()
    : success = true,
      errorCode = null,
      message = null;

  const AuthResult.failure(this.errorCode, this.message) : success = false;
}
