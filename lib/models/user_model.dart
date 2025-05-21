class UserModel {
  final String email;
  final String phone;
  final String country;
  final String userType;

  UserModel({
    required this.email,
    required this.phone,
    required this.country,
    required this.userType,
  });

  Map<String, dynamic> toMap() => {
    'email': email,
    'phone': phone,
    'country': country,
    'userType': userType,
  };

  factory UserModel.fromMap(Map<String, dynamic> map) => UserModel(
    email: map['email'] ?? '',
    phone: map['phone'] ?? '',
    country: map['country'] ?? '',
    userType: map['userType'] ?? '',
  );
}
