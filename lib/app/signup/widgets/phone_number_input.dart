import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../widgets/intl_phone_field/intl_phone_field.dart';
import '../bloc/sign_up.cubit.dart';

class PhoneNumberSignupInput extends StatelessWidget {
  final TextEditingController phoneNumberCont;

  const PhoneNumberSignupInput({super.key, required this.phoneNumberCont});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) =>
          previous.phoneNumber != current.phoneNumber,
      builder: (context, state) {
        return IntlPhoneField(
          controller: phoneNumberCont,
          onChanged: (phone) {
            context
                .read<SignUpCubit>()
                .phoneNumberChanged(phone.completeNumber);
            context.read<SignUpCubit>().countryCodeChanged(phone.countryCode);
            context
                .read<SignUpCubit>()
                .countryISOCodeChanged(phone.countryISOCode);
          },
          decoration: const InputDecoration(hintText: "9******00"),
        );
      },
    );
  }
}
