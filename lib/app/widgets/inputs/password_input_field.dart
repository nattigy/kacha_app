import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../utils/input_validators.dart';

class PasswordInputField extends StatefulWidget {
  final TextEditingController passwordCont;
  final TextEditingController? confirmPasswordCont;
  final Function onChanged;
  final bool isConfirm;

  const PasswordInputField({
    super.key,
    required this.passwordCont,
    required this.onChanged,
    this.confirmPasswordCont,
    this.isConfirm = false,
  });

  @override
  State<PasswordInputField> createState() => _PasswordInputFieldState();
}

class _PasswordInputFieldState extends State<PasswordInputField> {
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) => widget.isConfirm
          ? FormValidator.confirmPassword(
              widget.passwordCont.text,
              widget.confirmPasswordCont!.text,
            )
          : FormValidator.validatePassword(value),
      obscureText: obscureText,
      keyboardType: TextInputType.text,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: widget.passwordCont,
      onChanged: (password) => widget.onChanged(password),
      decoration: InputDecoration(
        hintText: widget.isConfirm ? "confirm password" : "password",
        prefixIcon: const Icon(Icons.lock),
        suffixIcon: _getSuffixWidget(),
      ),
    );
  }

  Widget _getSuffixWidget() {
    return ButtonTheme(
      child: TextButton(
        onPressed: () {
          setState(() {
            obscureText = !obscureText;
          });
        },
        child: Icon(
          (!obscureText) ? FontAwesomeIcons.eye : FontAwesomeIcons.eyeSlash,
        ),
      ),
    );
  }
}
