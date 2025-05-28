class UserModel {
  final String email;
  final String phone;
  final String country;
  final String userType;
  final String? profileImageUrl;

  UserModel({
    required this.email,
    required this.phone,
    required this.country,
    required this.userType,
    this.profileImageUrl,
  });

  Map<String, dynamic> toMap() => {
    'email': email,
    'phone': phone,
    'country': country,
    'userType': userType,
    if (profileImageUrl != null) 'profileImageUrl': profileImageUrl,
  };

  factory UserModel.fromMap(Map<String, dynamic> map) => UserModel(
    email: map['email'] ?? '',
    phone: map['phone'] ?? '',
    country: map['country'] ?? '',
    userType: map['userType'] ?? '',
    profileImageUrl: map['profileImageUrl'],
  );

  UserModel copyWith({
    String? email,
    String? phone,
    String? country,
    String? userType,
    String? profileImageUrl,
  }) {
    return UserModel(
      email: email ?? this.email,
      phone: phone ?? this.phone,
      country: country ?? this.country,
      userType: userType ?? this.userType,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
    );
  }
}
