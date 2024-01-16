import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../widgets/inputs/password_input_field.dart';
import '../bloc/login_cubit.dart';

class LoginPasswordInput extends StatelessWidget {
  final TextEditingController passwordCont;

  const LoginPasswordInput({super.key, required this.passwordCont});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return PasswordInputField(
          passwordCont: passwordCont,
          onChanged: (password) =>
              context.read<LoginCubit>().passwordChanged(password),
        );
      },
    );
  }
}
