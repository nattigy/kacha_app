import 'package:authentication_repository/authentication_repository.dart';

class PhoneRepository {
  PhoneRepository({required this.authenticationRepository});

  final AuthenticationRepository authenticationRepository;

  Future<String> sendPhoneOTP(
    String phoneNumber,
    String countryCode,
    String countryISOCode,
  ) async {
    return "";
    // return result.data?['sendPhoneOTP']['token'];
  }

  Future<String?> verifyPhoneOTP(String code, String token) async {
    // await authenticationRepository.persistToken(tokens['accessToken'], tokens['refreshToken']);
    return "Phone number verified!";
  }

  Future<String> forgotPassword(
    String phoneNumber,
    String countryCode,
    String countryISOCode,
  ) async {
    return "";
    // return result.data?['forgotPassword']['token'];
  }
}
