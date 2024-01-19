import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../utils/input_validators.dart';
import '../../widgets/inputs/text_input_field.dart';
import '../bloc/edit_user.cubit.dart';

class EditLastNameInput extends StatelessWidget {
  final TextEditingController lastNameCont;

  const EditLastNameInput({super.key, required this.lastNameCont});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditUserCubit, EditUserState>(
      buildWhen: (previous, current) => previous.lastName != current.lastName,
      builder: (context, state) {
        return TextInputField(
          validator: (value) => FormValidator.validateName(value),
          hintText: "Grand Father's Name",
          controller: lastNameCont,
          prefixIcon: const Icon(FontAwesomeIcons.solidUser, size: 16),
          onChanged: (username) =>
              context.read<EditUserCubit>().lastNameChanged(username),
        );
      },
    );
  }
}
