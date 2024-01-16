part of 'reset_password_cubit.dart';

class ResetPasswordState extends Equatable {
  final FormzSubmissionStatus status;
  final Password password;
  final Password confirmPassword;
  final bool isLoading;
  final bool isPasswordEqual;
  final String exceptionError;
  final bool isValid;

  const ResetPasswordState({
    this.status = FormzSubmissionStatus.initial,
    this.password = const Password.pure(),
    this.confirmPassword = const Password.pure(),
    this.isLoading = false,
    this.isPasswordEqual = false,
    this.exceptionError = "",
    this.isValid = false,
  });

  ResetPasswordState copyWith({
    FormzSubmissionStatus? status,
    PhoneNumberValidator? phoneNumber,
    Password? password,
    Password? confirmPassword,
    String? exceptionError,
    bool? isPasswordEqual,
    bool? isValid,
  }) {
    return ResetPasswordState(
      status: status ?? this.status,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      exceptionError: exceptionError ?? this.exceptionError,
      isPasswordEqual: isPasswordEqual ?? this.isPasswordEqual,
      isValid: isValid ?? this.isValid,
    );
  }

  @override
  List<Object> get props => [
        status,
        password,
        confirmPassword,
        isLoading,
        exceptionError,
        isPasswordEqual,
        isValid,
      ];
}
