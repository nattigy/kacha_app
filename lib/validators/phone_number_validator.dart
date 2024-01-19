import 'package:formz/formz.dart';
import 'package:inspection/inspection.dart';
import 'package:velocity_x/velocity_x.dart';

enum PhoneNumberValidationError { empty }

class PhoneNumberValidator
    extends FormzInput<String, PhoneNumberValidationError> {
  const PhoneNumberValidator.pure() : super.pure('');

  const PhoneNumberValidator.dirty([super.value = '']) : super.dirty();

  @override
  PhoneNumberValidationError? validator(String value) {
    if (value.isEmpty) {
      return PhoneNumberValidationError.empty;
    }

    final validate = Inspection().inspect(
      value,
      'required|numeric|min:3|max:16',
      name: "name",
      locale: "en",
      message: "invalid phone number",
    );
    if (validate.isEmptyOrNull) return null;
    return validate == "null" ? null : PhoneNumberValidationError.empty;
  }
}
