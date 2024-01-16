import 'package:formz/formz.dart';

import '../utils/input_validators.dart';

class EmailValidator extends FormzInput<String, String?> {
  const EmailValidator.pure() : super.pure('');

  const EmailValidator.dirty([super.value = '']) : super.dirty();

  @override
  String? validator(String value) => FormValidator.validateEmail(value);
}
