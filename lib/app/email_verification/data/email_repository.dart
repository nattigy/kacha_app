import '../../auth/data/auth_repository.dart';

class EmailRepository {
  EmailRepository({required this.authenticationRepository});

  final AuthenticationRepository authenticationRepository;

  Future<String> sendEmailOTP(String email) async {
    return "";
    // return result.data?['sendEmailOTP']['token'];
  }

  Future<String?> verifyEmailOTP(String code, String token) async {
    // await authenticationRepository.persistToken(tokens['accessToken'], tokens['refreshToken']);
    return "Email verified!";
  }
}