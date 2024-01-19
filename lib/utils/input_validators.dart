import 'package:basic_utils/basic_utils.dart';
import 'package:inspection/inspection.dart';
import 'package:velocity_x/velocity_x.dart';

class FormValidator {
  static String? validateName(String? value) {
    if (value!.length == 1) {
      return 'Name is too short';
    }
    if (value.isEmpty || value.trim().isEmpty) {
      return 'Invalid Name';
    }
    return null;
  }

  static String? validateAccountNumber(String? value) {
    if (value!.length != 13) {
      return 'Length should be 13!';
    }
    if (value.isEmpty || value.trim().isEmpty) {
      return 'Invalid Account Number';
    }
    return null;
  }

  static String? validateGender(String? value) {
    if (value.isEmptyOrNull) {
      return 'Input Your Gender';
    }
    if (value!.toLowerCase() != "male" && value.toLowerCase() != "female") {
      return 'Invalid Gender';
    }
    return null;
  }

  static String? validateEmail(String? value) {
    if (value!.isEmpty) {
      return 'Email is Empty ';
    }
    if (!EmailUtils.isEmail(value)) {
      return 'Invalid email address';
    }
    return null;
  }

  static String? validatePhone(String? value, {String? name}) {
    if (value!.isEmpty) {
      return 'Phone number is empty';
    }
    final validate = Inspection().inspect(
      value,
      'required|numeric|min:3|max:16',
      name: name,
      locale: "en",
      message: "Invalid phone number",
    );
    if (validate.isEmptyOrNull) {
      return (value.length != 9 ? "Phone number length too short" : null);
    }
    return validate == "null"
        ? (value.length != 9 ? "Phone number length too short" : null)
        : validate;
  }

  static String? validatePassword(String? value) {
    if (value!.isEmpty) {
      return "Password is Empty";
    }

    if (value.trim().isEmpty || value.length < 6) {
      return 'Password must be more than 6 character';
    }
    return null;
  }

  static String? confirmPassword(String? pass, String? confirm) {
    if (confirm!.isEmpty) {
      return "Password is Empty";
    }

    if (pass != confirm) {
      return "Password don't match";
    }
    return null;
  }
}
