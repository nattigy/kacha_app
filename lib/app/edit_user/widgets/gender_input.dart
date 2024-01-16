import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../widgets/inputs/dropdown_input.dart';
import '../bloc/edit_user.cubit.dart';

class EditUserGenderInput extends StatelessWidget {
  final TextEditingController genderCont;
  final gender = ['Female', 'Male'];
  final String genderValue;

  EditUserGenderInput(
      {super.key, required this.genderCont, required this.genderValue});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditUserCubit, EditUserState>(
      buildWhen: (previous, current) => previous.gender != current.gender,
      builder: (context, state) {
        return DropDownInput(
          itemText: "Gender",
          itemController: genderCont,
          itemMap: gender,
          onChange: (String? newValue) {
            genderCont.text = newValue!;
            context.read<EditUserCubit>().genderChanged(newValue.toUpperCase());
          },
        );
      },
    );
  }
}
