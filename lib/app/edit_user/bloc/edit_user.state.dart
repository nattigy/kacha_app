part of 'edit_user.cubit.dart';

class EditUserState extends Equatable {
  final FormzSubmissionStatus status;
  final UsernameValidator firstName;
  final UsernameValidator middleName;
  final UsernameValidator lastName;
  final GenderValidator gender;
  final String exceptionError;
  final bool isValid;

  const EditUserState({
    this.status = FormzSubmissionStatus.initial,
    this.firstName = const UsernameValidator.pure(),
    this.middleName = const UsernameValidator.pure(),
    this.lastName = const UsernameValidator.pure(),
    this.gender = const GenderValidator.pure(),
    this.exceptionError = "",
    this.isValid = false,
  });

  EditUserState copyWith({
    FormzSubmissionStatus? status,
    UsernameValidator? firstName,
    UsernameValidator? middleName,
    UsernameValidator? lastName,
    GenderValidator? gender,
    String? exceptionError,
    bool? isValid,
  }) {
    return EditUserState(
      status: status ?? this.status,
      firstName: firstName ?? this.firstName,
      middleName: middleName ?? this.middleName,
      lastName: lastName ?? this.lastName,
      gender: gender ?? this.gender,
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
        gender,
        exceptionError,
        isValid,
      ];
}
