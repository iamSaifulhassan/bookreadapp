abstract class SigninState {}

class SigninInitial extends SigninState {}

class SigninLoading extends SigninState {}

class SigninSuccess extends SigninState {
  /// Distinguishes which flow succeeded, since email and Google sign-in
  /// show different success messages.
  final bool viaGoogle;
  SigninSuccess({this.viaGoogle = false});
}

class SigninFailure extends SigninState {
  final String message;
  final bool viaGoogle;
  SigninFailure(this.message, {this.viaGoogle = false});
}
