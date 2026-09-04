abstract class SignupState {}

class SignupInitial extends SignupState {}

class SignupLoading extends SignupState {}

class SignupSuccess extends SignupState {}

class SignupFailure extends SignupState {
  final String message;
  final String? errorCode;
  SignupFailure(this.message, {this.errorCode});
}
