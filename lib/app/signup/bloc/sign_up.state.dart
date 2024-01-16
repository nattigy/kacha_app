part of 'sign_up.cubit.dart';

class SignUpState extends Equatable {
  final FormzSubmissionStatus status;
  final UsernameValidator firstName;
  final UsernameValidator middleName;
  final UsernameValidator lastName;
  final EmailValidator email;
  final PhoneNumberValidator phoneNumber;
  final UsernameValidator countryCode;
  final UsernameValidator countryISOCode;
  final GenderValidator gender;
  final Password password;
  final Password confirmPassword;
  final String exceptionError;
  final bool isValid;

  const SignUpState({
    this.status = FormzSubmissionStatus.initial,
    this.firstName = const UsernameValidator.pure(),
    this.middleName = const UsernameValidator.pure(),
    this.lastName = const UsernameValidator.pure(),
    this.phoneNumber = const PhoneNumberValidator.pure(),
    this.countryCode = const UsernameValidator.pure(),
    this.countryISOCode = const UsernameValidator.pure(),
    this.email = const EmailValidator.pure(),
    this.gender = const GenderValidator.pure(),
    this.password = const Password.pure(),
    this.confirmPassword = const Password.pure(),
    this.exceptionError = "",
    this.isValid = false,
  });

  SignUpState copyWith({
    FormzSubmissionStatus? status,
    UsernameValidator? firstName,
    UsernameValidator? middleName,
    UsernameValidator? lastName,
    PhoneNumberValidator? phoneNumber,
    UsernameValidator? countryISOCode,
    UsernameValidator? countryCode,
    EmailValidator? email,
    GenderValidator? gender,
    Password? password,
    Password? confirmPassword,
    String? exceptionError,
    bool? isValid,
  }) {
    return SignUpState(
      status: status ?? this.status,
      firstName: firstName ?? this.firstName,
      middleName: middleName ?? this.middleName,
      lastName: lastName ?? this.lastName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      countryISOCode: countryISOCode ?? this.countryISOCode,
      countryCode: countryCode ?? this.countryCode,
      email: email ?? this.email,
      gender: gender ?? this.gender,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      exceptionError: exceptionError ?? this.exceptionError,
      isValid: isValid ?? this.isValid,
    );
  }

  @override
  List<Object> get props => [
        status,
        firstName,
        middleName,
        lastName,
        countryISOCode,
        countryCode,
        phoneNumber,
        email,
        gender,
        password,
        confirmPassword,
        exceptionError,
        isValid,
      ];
}
