import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../utils/input_validators.dart';
import '../../widgets/inputs/custom_text_form_field.dart';
import '../bloc/reset_password_cubit.dart';

class ResetPasswordConfirmPasswordInput extends StatelessWidget {
  final TextEditingController confirmPasswordCont;

  const ResetPasswordConfirmPasswordInput(
      {super.key, required this.confirmPasswordCont});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ResetPasswordCubit, ResetPasswordState>(
      buildWhen: (previous, current) =>
          previous.confirmPassword != current.confirmPassword,
      builder: (context, state) {
        return CustomTextFormField(
          validator: (value) => FormValidator.validatePassword(value),
          key: const Key('loginForm_passwordInput_textField'),
          hintText: "confirm password",
          obscureText: true,
          keyboardType: TextInputType.text,
          textEditingController: confirmPasswordCont,
          errorText: state.confirmPassword.isPure
              ? null
              : state.confirmPassword.isNotValid
                  ? 'invalid password'
                  : state.confirmPassword.value != state.password.value
                      ? "password don't match"
                      : null,
          onChanged: (password) => context
              .read<ResetPasswordCubit>()
              .confirmPasswordChanged(password),
        ).pOnly(bottom: 12);
      },
    );
  }
}
