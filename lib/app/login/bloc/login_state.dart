part of 'login_cubit.dart';

class LoginState extends Equatable {
  final FormzSubmissionStatus status;
  final PhoneNumberValidator phoneNumber;
  final Password password;
  final bool isLoading;
  final String exceptionError;
  final bool isValid;

  const LoginState({
    this.status = FormzSubmissionStatus.initial,
    this.phoneNumber = const PhoneNumberValidator.pure(),
    this.password = const Password.pure(),
    this.isLoading = false,
    this.exceptionError = "",
    this.isValid = false,
  });

  LoginState copyWith({
    FormzSubmissionStatus? status,
    PhoneNumberValidator? phoneNumber,
    Password? password,
    String? exceptionError,
    bool? isValid,
  }) {
    return LoginState(
      status: status ?? this.status,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      password: password ?? this.password,
      exceptionError: exceptionError ?? this.exceptionError,
      isValid: isValid ?? this.isValid,
    );
  }

  @override
  List<Object> get props => [
        status,
        phoneNumber,
        password,
        isLoading,
        exceptionError,
        isValid,
      ];
}
