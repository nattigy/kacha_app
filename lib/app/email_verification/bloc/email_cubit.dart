import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utils/error_string.dart';
import '../../auth/data/auth_repository.dart';
import '../data/email_repository.dart';

part 'email_state.dart';

class EmailCubit extends Cubit<EmailState> {
  EmailCubit({required this.emailRepository}) : super(EmailUnknown());

  final EmailRepository emailRepository;

  Future<void> verifyEmailOTP(String code, String token) async {
    emit(EmailVerifying());
    try {
      await emailRepository.verifyEmailOTP(code, token);
      emit(EmailSuccessful());
      emit(EmailUnknown());
    } catch (e) {
      emit(EmailVerificationFailure(errorString(e)));
      emit(EmailUnknown());
    }
  }

  Future<void> sendEmailOTP(String email) async {
    emit(EmailLoading());
    try {
      final token = await emailRepository.sendEmailOTP(email);
      emit(EmailAuthCodeSent(token));
    } catch (e) {
      emit(EmailVerificationFailure(errorString(e)));
      emit(EmailUnknown());
    }
  }
}
