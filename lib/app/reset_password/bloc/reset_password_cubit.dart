import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '../../../utils/error_string.dart';
import '../../../validators/password_validator.dart';
import '../../../validators/phone_number_validator.dart';
import '../../auth/data/auth_repository.dart';
import '../data/reset_password_repository.dart';

part 'reset_password_state.dart';

class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  final ResetPasswordRepository resetPasswordRepository;

  ResetPasswordCubit({required this.resetPasswordRepository})
      : super(const ResetPasswordState());

  void passwordChanged(String value) {
    final password = Password.dirty(value);
    bool isPasswordEqual = false;
    if (password.value == state.confirmPassword.value) isPasswordEqual = true;
    emit(
      state.copyWith(
        password: password,
        isPasswordEqual: isPasswordEqual,
        isValid: Formz.validate([
          password,
          state.confirmPassword,
        ]),
      ),
    );
  }

  void confirmPasswordChanged(String value) {
    final confirmPassword = Password.dirty(value);
    bool isPasswordEqual = false;
    if (confirmPassword.value == state.password.value) isPasswordEqual = true;
    emit(
      state.copyWith(
        confirmPassword: confirmPassword,
        isPasswordEqual: isPasswordEqual,
        isValid: Formz.validate([
          confirmPassword,
          state.password,
        ]),
      ),
    );
  }

  Future<void> resetPassword() async {
    if (!state.isValid) return;
    if (!state.isPasswordEqual) {
      emit(state.copyWith(
          status: FormzSubmissionStatus.failure,
          exceptionError: "Passwords don't match!"));
      return;
    }
    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
    try {
      !state.isLoading;
      await resetPasswordRepository.resetPassword(state.password.value);
      emit(state.copyWith(status: FormzSubmissionStatus.success));
    } catch (e) {
      !state.isLoading;
      emit(state.copyWith(
        status: FormzSubmissionStatus.failure,
        exceptionError: errorString(e),
      ));
      emit(state.copyWith(status: FormzSubmissionStatus.initial));
    }
  }
}
