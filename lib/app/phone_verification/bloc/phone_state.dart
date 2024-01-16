part of 'phone_cubit.dart';

class PhoneState extends Equatable {
  final FormzSubmissionStatus status;
  final PhoneNumberValidator phoneNumber;
  final UsernameValidator countryCode;
  final UsernameValidator countryISOCode;
  final UsernameValidator code;
  final String exceptionError;
  final String phoneVerificationToken;
  final bool isValid;
  final bool phoneVerified;
  final bool phoneCodeSent;

  const PhoneState({
    this.status = FormzSubmissionStatus.initial,
    this.phoneNumber = const PhoneNumberValidator.pure(),
    this.countryCode = const UsernameValidator.pure(),
    this.countryISOCode = const UsernameValidator.pure(),
    this.code = const UsernameValidator.pure(),
    this.exceptionError = "",
    this.isValid = false,
    this.phoneCodeSent = false,
    this.phoneVerified = false,
    this.phoneVerificationToken = "",
  });

  PhoneState copyWith({
    FormzSubmissionStatus? status,
    PhoneNumberValidator? phoneNumber,
    UsernameValidator? countryISOCode,
    UsernameValidator? countryCode,
    UsernameValidator? code,
    String? exceptionError,
    String? phoneVerificationToken,
    bool? isValid,
    bool? phoneCodeSent,
    bool? phoneVerified,
  }) {
    return PhoneState(
      status: status ?? this.status,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      countryISOCode: countryISOCode ?? this.countryISOCode,
      countryCode: countryCode ?? this.countryCode,
      code: code ?? this.code,
      exceptionError: exceptionError ?? "",
      phoneVerificationToken:
          phoneVerificationToken ?? this.phoneVerificationToken,
      phoneVerified: phoneVerified ?? this.phoneVerified,
      phoneCodeSent: phoneCodeSent ?? this.phoneCodeSent,
      isValid: isValid ?? this.isValid,
    );
  }

  @override
  List<Object> get props => [
        status,
        countryISOCode,
        countryCode,
        code,
        phoneNumber,
        exceptionError,
        isValid,
        phoneVerificationToken,
        phoneVerified,
        phoneCodeSent,
      ];
}
