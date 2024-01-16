import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '../../../utils/error_string.dart';
import '../../../validators/validators.dart';
import '../data/phone_repository.dart';

part 'phone_state.dart';

class PhoneCubit extends Cubit<PhoneState> {
  final PhoneRepository phoneRepository;

  PhoneCubit({required this.phoneRepository}) : super(const PhoneState());

  void phoneNumberChanged(String value) {
    final phoneNumber = PhoneNumberValidator.dirty(value);
    emit(
      state.copyWith(
        phoneNumber: phoneNumber,
        isValid: Formz.validate([
          phoneNumber,
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
          state.phoneNumber,
          countryCode,
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
          state.phoneNumber,
          countryISOCode,
          state.countryCode,
        ]),
      ),
    );
  }

  void codeChanged(String value) {
    final code = UsernameValidator.dirty(value);
    emit(
      state.copyWith(
        code: code,
        isValid: Formz.validate([
          state.phoneNumber,
          code,
          state.countryCode,
          state.countryISOCode,
        ]),
      ),
    );
  }

  Future<void> sendPhoneOTP() async {
    if (!state.isValid) return;
    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
    try {
      String token = await phoneRepository.sendPhoneOTP(
        state.phoneNumber.value,
        state.countryCode.value,
        state.countryISOCode.value,
      );
      emit(state.copyWith(
        phoneVerificationToken: token,
        phoneCodeSent: true,
        status: FormzSubmissionStatus.initial,
      ));
      emit(state.copyWith(phoneCodeSent: false));
    } catch (e) {
      emit(state.copyWith(
        status: FormzSubmissionStatus.failure,
        exceptionError: errorString(e),
      ));
      emit(state.copyWith(
        status: FormzSubmissionStatus.initial,
        exceptionError: "",
      ));
    }
  }

  Future<void> forgotPassword() async {
    if (!state.isValid) return;
    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
    try {
      String token = await phoneRepository.forgotPassword(
        state.phoneNumber.value,
        state.countryCode.value,
        state.countryISOCode.value,
      );
      emit(state.copyWith(
        phoneVerificationToken: token,
        phoneCodeSent: true,
        status: FormzSubmissionStatus.initial,
      ));
      emit(state.copyWith(phoneCodeSent: false));
    } catch (e) {
      emit(state.copyWith(
        status: FormzSubmissionStatus.failure,
        exceptionError: errorString(e),
      ));
      emit(state.copyWith(
          status: FormzSubmissionStatus.initial, exceptionError: ""));
    }
  }

  Future<void> verifyPhoneOTP() async {
    if (!state.isValid) return;
    if (state.code.isNotValid) return;
    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
    try {
      await phoneRepository.verifyPhoneOTP(
        state.code.value,
        state.phoneVerificationToken,
      );
      emit(state.copyWith(
          phoneVerified: true, status: FormzSubmissionStatus.success));
      emit(state.copyWith(
          status: FormzSubmissionStatus.initial, phoneVerified: false));
    } catch (e) {
      emit(state.copyWith(
        status: FormzSubmissionStatus.failure,
        exceptionError: errorString(e),
      ));
      emit(state.copyWith(
        exceptionError: "",
        status: FormzSubmissionStatus.initial,
      ));
    }
  }
}
