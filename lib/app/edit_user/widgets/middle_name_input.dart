import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../utils/input_validators.dart';
import '../../widgets/inputs/text_input_field.dart';
import '../bloc/edit_user.cubit.dart';

class EditUserMiddleNameInput extends StatelessWidget {
  final TextEditingController middleNameCont;

  const EditUserMiddleNameInput({super.key, required this.middleNameCont});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditUserCubit, EditUserState>(
      buildWhen: (previous, current) =>
          previous.middleName != current.middleName,
      builder: (context, state) {
        return TextInputField(
          validator: (value) => FormValidator.validateName(value),
          hintText: "Father's Name",
          controller: middleNameCont,
          prefixIcon: const Icon(FontAwesomeIcons.solidUser, size: 16),
          onChanged: (username) =>
              context.read<EditUserCubit>().middleNameChanged(username),
        );
      },
    );
  }
}
