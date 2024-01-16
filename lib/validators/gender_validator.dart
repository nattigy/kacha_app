import 'package:formz/formz.dart';

import '../app/user/enum/user.enums.dart';

enum GenderValidationError { empty }

class GenderValidator
    extends FormzInput<UserGenderEnum, GenderValidationError> {
  const GenderValidator.pure() : super.pure(UserGenderEnum.FEMALE);

  const GenderValidator.dirty([super.value = UserGenderEnum.FEMALE])
      : super.dirty();

  @override
  GenderValidationError? validator(UserGenderEnum? value) {
    return value?.name.isNotEmpty == true ? null : GenderValidationError.empty;
  }
}
