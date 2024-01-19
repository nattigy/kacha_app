import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../utils/input_validators.dart';
import '../../widgets/inputs/text_input_field.dart';
import '../bloc/edit_user.cubit.dart';

class EditUserFirstNameInput extends StatelessWidget {
  final TextEditingController firstNameCont;

  const EditUserFirstNameInput({super.key, required this.firstNameCont});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditUserCubit, EditUserState>(
      buildWhen: (previous, current) => previous.firstName != current.firstName,
      builder: (context, state) {
        return TextInputField(
          validator: (value) => FormValidator.validateName(value),
          hintText: "Given Name",
          controller: firstNameCont,
          prefixIcon: const Icon(FontAwesomeIcons.solidUser, size: 16),
          onChanged: (username) =>
              context.read<EditUserCubit>().firstNameChanged(username),
        );
      },
    );
  }
}
