abstract class SigninEvent {}

class SigninSubmitted extends SigninEvent {
  final String email;
  final String password;
  SigninSubmitted({required this.email, required this.password});
}
