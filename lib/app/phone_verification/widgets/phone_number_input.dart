import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../widgets/intl_phone_field/intl_phone_field.dart';
import '../../widgets/intl_phone_field/phone_number.dart';
import '../bloc/phone_cubit.dart';

class EditPhoneNumberInput extends StatelessWidget {
  final TextEditingController phoneNumberCont;
  final void Function(PhoneNumber phone) onChanged;

  const EditPhoneNumberInput({
    super.key,
    required this.phoneNumberCont,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PhoneCubit, PhoneState>(
      buildWhen: (previous, current) =>
          previous.phoneNumber != current.phoneNumber &&
          previous.countryISOCode != current.countryISOCode &&
          previous.countryCode != current.countryCode,
      builder: (context, state) {
        return IntlPhoneField(
          controller: phoneNumberCont,
          initialCountryCode: state.countryISOCode.value,
          onChanged: (phone) => onChanged(phone),
          decoration: const InputDecoration(hintText: "9******00"),
        );
      },
    );
  }
}
