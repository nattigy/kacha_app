import '../../auth/data/auth_repository.dart';

class ResetPasswordRepository {
  ResetPasswordRepository({required this.authenticationRepository});

  final AuthenticationRepository authenticationRepository;

  Future<void> resetPassword(String password) async {
    // await authenticationRepository.persistToken(tokens['accessToken'], tokens['refreshToken']);
  }
}