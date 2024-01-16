
import '../../user/enum/user.enums.dart';

class SignUpInput {
  final String fullName;
  final String phoneNumber;
  final String countryCode;
  final String countryISOCode;
  final String email;
  final String password;
  final UserGenderEnum gender;

  SignUpInput({
    required this.fullName,
    required this.phoneNumber,
    required this.countryCode,
    required this.countryISOCode,
    required this.email,
    required this.password,
    required this.gender,
  });

  Map<String, dynamic> toJson() {
    return {
      "fullName": fullName.trim(),
      "phoneNumber": phoneNumber,
      "countryCode": countryCode,
      "countryISOCode": countryISOCode,
      "email": email,
      "password": password,
      "gender": gender.name,
      "whichApp": "tutorApp",
    };
  }
}
