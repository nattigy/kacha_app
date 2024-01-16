import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utils/input_validators.dart';
import '../../widgets/inputs/text_input_field.dart';
import '../bloc/sign_up.cubit.dart';

class FirstNameSignupInput extends StatelessWidget {
  final TextEditingController firstNameCont;

  const FirstNameSignupInput({super.key, required this.firstNameCont});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) => previous.firstName != current.firstName,
      builder: (context, state) {
        return TextInputField(
          validator: (value) => FormValidator.validateName(value),
          controller: firstNameCont,
          onChanged: (username) =>
              context.read<SignUpCubit>().firstNameChanged(username),
          hintText: "Given Name",
          prefixIcon: const Icon(Icons.person),
        );
      },
    );
  }
}

class MiddleNameSignupInput extends StatelessWidget {
  final TextEditingController middleNameCont;

  const MiddleNameSignupInput({super.key, required this.middleNameCont});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) =>
          previous.middleName != current.middleName,
      builder: (context, state) {
        return TextInputField(
          validator: (value) => FormValidator.validateName(value),
          controller: middleNameCont,
          onChanged: (username) =>
              context.read<SignUpCubit>().middleNameChanged(username),
          hintText: "Father's Name",
          prefixIcon: const Icon(Icons.person),
        );
      },
    );
  }
}

class LastNameSignupInput extends StatelessWidget {
  final TextEditingController lastNameCont;

  const LastNameSignupInput({super.key, required this.lastNameCont});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) => previous.lastName != current.lastName,
      builder: (context, state) {
        return TextInputField(
          validator: (value) => FormValidator.validateName(value),
          controller: lastNameCont,
          onChanged: (username) =>
              context.read<SignUpCubit>().lastNameChanged(username),
          hintText: "Grand Father's Name",
          prefixIcon: const Icon(Icons.person),
        );
      },
    );
  }
}
