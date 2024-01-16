import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '../../../utils/error_string.dart';
import '../../../utils/firebase_events_logger.dart';
import '../../../validators/validators.dart';
import '../../auth/data/auth_repository.dart';
import '../dto/login_input.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthenticationRepository authenticationRepository;

  LoginCubit({required this.authenticationRepository})
      : super(const LoginState());

  void phoneNumberChanged(String value) {
    final phoneNumber = PhoneNumberValidator.dirty(value);
    emit(state.copyWith(
      phoneNumber: phoneNumber,
      isValid: Formz.validate([phoneNumber, state.password]),
    ));
  }

  void passwordChanged(String value) {
    final password = Password.dirty(value);
    emit(state.copyWith(
      password: password,
      isValid: Formz.validate([state.phoneNumber, password]),
    ));
  }

  Future<void> submitLogin() async {
    if (!state.isValid) return;
    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
    try {
      !state.isLoading;
      await authenticationRepository.logIn(LoginInput(
        phoneNumber: state.phoneNumber.value,
        password: state.password.value,
      ));
      emit(state.copyWith(status: FormzSubmissionStatus.success));
      emit(state.copyWith(status: FormzSubmissionStatus.initial));
    } catch (e) {
      !state.isLoading;
      analyticsLoginError(e);
      emit(state.copyWith(
        status: FormzSubmissionStatus.failure,
        exceptionError: errorString(e),
      ));
      emit(state.copyWith(status: FormzSubmissionStatus.initial));
    }
  }
}
