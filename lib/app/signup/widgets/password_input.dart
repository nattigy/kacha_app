import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../widgets/inputs/password_input_field.dart';
import '../bloc/sign_up.cubit.dart';

class PasswordSignupInput extends StatelessWidget {
  final TextEditingController passwordCont;

  const PasswordSignupInput({super.key, required this.passwordCont});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return PasswordInputField(
          passwordCont: passwordCont,
          onChanged: (password) =>
              context.read<SignUpCubit>().passwordChanged(password),
        );
      },
    );
  }
}

class ConfirmPasswordSignupInput extends StatelessWidget {
  final TextEditingController confirmPasswordCont;
  final TextEditingController password;

  const ConfirmPasswordSignupInput({
    super.key,
    required this.confirmPasswordCont,
    required this.password,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) =>
          previous.confirmPassword != current.confirmPassword,
      builder: (context, state) {
        return PasswordInputField(
          passwordCont: confirmPasswordCont,
          confirmPasswordCont: password,
          isConfirm: true,
          onChanged: (password) =>
              context.read<SignUpCubit>().confirmPasswordChanged(password),
        );
      },
    );
  }
}
