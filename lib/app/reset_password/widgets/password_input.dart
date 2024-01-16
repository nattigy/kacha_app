import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../utils/input_validators.dart';
import '../../widgets/inputs/custom_text_form_field.dart';
import '../bloc/reset_password_cubit.dart';

class ResetPasswordInput extends StatelessWidget {
  final TextEditingController passwordCont;

  const ResetPasswordInput({super.key, required this.passwordCont});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ResetPasswordCubit, ResetPasswordState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return CustomTextFormField(
          validator: (value) => FormValidator.validatePassword(value),
          key: const Key('loginForm_passwordInput_textField'),
          hintText: "new password",
          obscureText: true,
          keyboardType: TextInputType.text,
          textEditingController: passwordCont,
          errorText: state.password.isPure
              ? null
              : state.password.isNotValid
                  ? 'invalid password'
                  : null,
          onChanged: (password) =>
              context.read<ResetPasswordCubit>().passwordChanged(password),
        ).pOnly(bottom: 12);
      },
    );
  }
}
