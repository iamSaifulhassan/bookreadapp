abstract class SignupEvent {}

class SignupSubmitted extends SignupEvent {
  final String email;
  final String phone;
  final String country;
  final String userType;
  final String password;
  SignupSubmitted({
    required this.email,
    required this.phone,
    required this.country,
    required this.userType,
    required this.password,
  });
}
