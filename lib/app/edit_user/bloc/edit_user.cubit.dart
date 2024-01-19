import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '../../../utils/error_string.dart';
import '../../../validators/validators.dart';
import '../../user/data/user.repository.dart';
import '../../user/enum/user.enums.dart';
import '../dto/edit_user.input.dart';

part 'edit_user.state.dart';

class EditUserCubit extends Cubit<EditUserState> {
  final UserRepository userRepository;

  EditUserCubit({required this.userRepository}) : super(const EditUserState());

  void editUserPopulateAll(
    String fName,
    String mName,
    String lName,
    UserGenderEnum g,
  ) {
    final firstName = UsernameValidator.dirty(fName);
    final middleName = UsernameValidator.dirty(mName);
    final lastName = UsernameValidator.dirty(lName);
    final gender = GenderValidator.dirty(g);

    emit(
      state.copyWith(
        firstName: firstName,
        middleName: middleName,
        lastName: lastName,
        gender: gender,
        isValid: Formz.validate([
          firstName,
          middleName,
          lastName,
          gender,
        ]),
      ),
    );
  }

  void firstNameChanged(String value) {
    final firstName = UsernameValidator.dirty(value);
    emit(
      state.copyWith(
        firstName: firstName,
        isValid: Formz.validate([
          firstName,
          state.middleName,
          state.lastName,
          state.gender,
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
          state.firstName,
          middleName,
          state.lastName,
          state.gender,
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
          state.firstName,
          state.middleName,
          lastName,
          state.gender,
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
          state.firstName,
          state.middleName,
          state.lastName,
          gender,
        ]),
      ),
    );
  }

  Future<void> submitEditUser() async {
    if (!state.isValid) return;
    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
    try {
      await userRepository.editUser(EditUserInput(
        fullName:
            "${state.firstName.value.trim().replaceAll(" ", "")} ${state.middleName.value.trim().replaceAll(" ", "")} ${state.lastName.value.trim().replaceAll(" ", "")}",
        gender: state.gender.value,
      ));
      emit(state.copyWith(status: FormzSubmissionStatus.success));
      emit(state.copyWith(status: FormzSubmissionStatus.initial));
    } catch (e) {
      emit(state.copyWith(
        status: FormzSubmissionStatus.failure,
        exceptionError: errorString(e),
      ));
      emit(state.copyWith(status: FormzSubmissionStatus.initial));
    }
  }
}
