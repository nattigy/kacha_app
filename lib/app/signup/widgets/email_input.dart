import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utils/input_validators.dart';
import '../../widgets/inputs/text_input_field.dart';
import '../bloc/sign_up.cubit.dart';

class EmailSignupInput extends StatelessWidget {
  final TextEditingController emailCont;

  const EmailSignupInput({super.key, required this.emailCont});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return TextInputField(
          validator: (value) => FormValidator.validateEmail(value),
          controller: emailCont,
          keyboardType: TextInputType.emailAddress,
          onChanged: (username) =>
              context.read<SignUpCubit>().emailChanged(username),
          hintText: "email@gmail.com",
          prefixIcon: const Icon(Icons.alternate_email_rounded),
        );
      },
    );
  }
}
