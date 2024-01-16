import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '../../../utils/error_string.dart';
import '../../../utils/firebase_events_logger.dart';
import '../../../validators/email_validator.dart';
import '../../../validators/gender_validator.dart';
import '../../../validators/password_validator.dart';
import '../../../validators/phone_number_validator.dart';
import '../../../validators/username_validator.dart';
import '../../auth/data/auth_repository.dart';
import '../../user/enum/user.enums.dart';
import '../dto/sign_up.input.dart';

part 'sign_up.state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  final AuthenticationRepository authenticationRepository;

  SignUpCubit({required this.authenticationRepository})
      : super(const SignUpState());

  void firstNameChanged(String value) {
    final firstName = UsernameValidator.dirty(value);
    emit(
      state.copyWith(
        firstName: firstName,
        isValid: Formz.validate([
          state.password,
          state.confirmPassword,
          firstName,
          state.middleName,
          state.lastName,
          state.gender,
          state.phoneNumber,
          state.email,
          state.countryCode,
          state.countryISOCode,
        ]),
      ),
    );
  }

  void middleNameChanged(String value) {
    final middleName = UsernameValidator.dirty(value);
    emit(
      state.copyWith(
        middleName: middleName,
        isValid: Formz.validate([
          state.password,
          state.confirmPassword,
          state.firstName,
          middleName,
          state.lastName,
          state.gender,
          state.phoneNumber,
          state.email,
          state.countryCode,
          state.countryISOCode,
        ]),
      ),
    );
  }

  void lastNameChanged(String value) {
    final lastName = UsernameValidator.dirty(value);
    emit(
      state.copyWith(
        lastName: lastName,
        isValid: Formz.validate([
          state.password,
          state.confirmPassword,
          state.firstName,
          state.middleName,
          lastName,
          state.gender,
          state.phoneNumber,
          state.email,
          state.countryCode,
          state.countryISOCode,
        ]),
      ),
    );
  }

  void phoneNumberChanged(String value) {
    final phoneNumber = PhoneNumberValidator.dirty(value);
    emit(
      state.copyWith(
        phoneNumber: phoneNumber,
        isValid: Formz.validate([
          state.password,
          state.confirmPassword,
          state.firstName,
          state.middleName,
          state.lastName,
          state.gender,
          phoneNumber,
          state.email,
          state.countryCode,
          state.countryISOCode,
        ]),
      ),
    );
  }

  void countryCodeChanged(String value) {
    final countryCode = UsernameValidator.dirty(value);
    emit(
      state.copyWith(
        countryCode: countryCode,
        isValid: Formz.validate([
          state.password,
          state.confirmPassword,
          state.firstName,
          state.middleName,
          state.lastName,
          state.gender,
          state.phoneNumber,
          countryCode,
          state.email,
          state.countryISOCode,
        ]),
      ),
    );
  }

  void countryISOCodeChanged(String value) {
    final countryISOCode = UsernameValidator.dirty(value);
    emit(
      state.copyWith(
        countryISOCode: countryISOCode,
        isValid: Formz.validate([
          state.password,
          state.confirmPassword,
          state.firstName,
          state.middleName,
          state.lastName,
          state.gender,
          state.phoneNumber,
          countryISOCode,
          state.email,
          state.countryCode,
        ]),
      ),
    );
  }

  void emailChanged(String value) {
    final email = EmailValidator.dirty(value);
    emit(
      state.copyWith(
        email: email,
        isValid: Formz.validate([
          state.password,
          state.confirmPassword,
          state.firstName,
          state.middleName,
          state.lastName,
          state.gender,
          state.phoneNumber,
          email,
          state.countryCode,
          state.countryISOCode,
        ]),
      ),
    );
  }

  void genderChanged(String value) {
    final enumVal =
        value == "MALE" ? UserGenderEnum.MALE : UserGenderEnum.FEMALE;
    final gender = GenderValidator.dirty(enumVal);
    emit(
      state.copyWith(
        gender: gender,
        isValid: Formz.validate([
          state.password,
          state.confirmPassword,
          state.firstName,
          state.middleName,
          state.lastName,
          gender,
          state.phoneNumber,
          state.email,
          state.countryCode,
          state.countryISOCode,
        ]),
      ),
    );
  }

  void passwordChanged(String value) {
    final password = Password.dirty(value);
    emit(
      state.copyWith(
        password: password,
        isValid: Formz.validate([
          password,
          state.confirmPassword,
          state.firstName,
          state.middleName,
          state.lastName,
          state.gender,
          state.phoneNumber,
          state.email,
          state.countryCode,
          state.countryISOCode,
        ]),
      ),
    );
  }

  void confirmPasswordChanged(String value) {
    final confirmPassword = Password.dirty(value);
    emit(
      state.copyWith(
        confirmPassword: confirmPassword,
        isValid: Formz.validate([
          confirmPassword,
          state.password,
          state.firstName,
          state.middleName,
          state.lastName,
          state.gender,
          state.phoneNumber,
          state.email,
          state.countryCode,
          state.countryISOCode,
        ]),
      ),
    );
  }

  Future<void> submitSignUp() async {
    if (!state.isValid) return;
    if (state.confirmPassword == state.password) {
      emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
      try {
        await authenticationRepository.signUp(SignUpInput(
          fullName:
              "${state.firstName.value.trim().replaceAll(" ", "")} ${state.middleName.value.trim().replaceAll(" ", "")} ${state.lastName.value.trim().replaceAll(" ", "")}",
          phoneNumber: state.phoneNumber.value,
          countryISOCode: state.countryISOCode.value,
          countryCode: state.countryCode.value,
          email: state.email.value,
          gender: state.gender.value,
          password: state.password.value,
        ));
        analyticsSignUpSuccess();
        emit(state.copyWith(status: FormzSubmissionStatus.success));
        emit(state.copyWith(status: FormzSubmissionStatus.initial));
      } catch (e) {
        analyticsSignUpError(e);
        emit(state.copyWith(
          status: FormzSubmissionStatus.failure,
          exceptionError: errorString(e),
        ));
        emit(state.copyWith(status: FormzSubmissionStatus.initial));
      }
    }
  }
}
