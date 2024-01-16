class LoginInput {
  final String phoneNumber;
  final String password;

  LoginInput({required this.phoneNumber, required this.password});

  Map<String, dynamic> toJson() {
    return {
      'phoneNumber': phoneNumber,
      'password': password,
    };
  }
}
