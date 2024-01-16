import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../widgets/intl_phone_field/intl_phone_field.dart';
import '../bloc/login_cubit.dart';

class LoginPhoneNumberInput extends StatelessWidget {
  final TextEditingController phoneNumberCont;

  const LoginPhoneNumberInput({super.key, required this.phoneNumberCont});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) =>
          previous.phoneNumber != current.phoneNumber,
      builder: (context, state) {
        return IntlPhoneField(
          controller: phoneNumberCont,
          onChanged: (phone) => context
              .read<LoginCubit>()
              .phoneNumberChanged(phone.completeNumber),
          decoration: const InputDecoration(hintText: "9******00"),
        );
      },
    );
  }
}
