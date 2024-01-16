import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../utils/navigator.dart';
import '../auth/bloc/auth_bloc.dart';
import '../widgets/buttons/main_button.dart';
import '../widgets/cards/max_width.dart';
import '../widgets/text/form-label-text.dart';
import 'bloc/phone_cubit.dart';
import 'phone_otp_page.dart';
import 'widgets/phone_number_input.dart';

class EditPhoneNumberPage extends StatefulWidget {
  const EditPhoneNumberPage({super.key});

  @override
  State<EditPhoneNumberPage> createState() => _EditPhoneNumberPageState();
}

class _EditPhoneNumberPageState extends State<EditPhoneNumberPage> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController phoneNumberCont = TextEditingController();

  String countryCode = "+251";
  String countryISOCode = "ET";

  @override
  void initState() {
    countryCode =
        context.read<AuthenticationBloc>().state.user.countryCode ?? "+251";
    countryISOCode =
        context.read<AuthenticationBloc>().state.user.countryISOCode ?? "ET";
    phoneNumberCont.text = context
        .read<AuthenticationBloc>()
        .state
        .user
        .phoneNumber
        .replaceAll(countryCode, "");
    context.read<PhoneCubit>().phoneNumberChanged(
          context.read<AuthenticationBloc>().state.user.phoneNumber,
        );
    context.read<PhoneCubit>().countryCodeChanged(countryCode);
    context.read<PhoneCubit>().countryISOCodeChanged(countryISOCode);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(title: const Text("Edit phone number")),
      body: MaxWidth(
        child: BlocConsumer<PhoneCubit, PhoneState>(
          listener: (context, state) {
            if (state.phoneCodeSent) {
              navigatorPush(context, PhoneOtpPage());
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    "Verification code has been sent to your phone number.",
                  ),
                  duration: Duration(seconds: 3),
                ),
              );
            }
            if (state.status == FormzSubmissionStatus.success) {
              context
                  .read<AuthenticationBloc>()
                  .add(AuthenticationReFetchUserChanged());
            }
            if (state.status == FormzSubmissionStatus.failure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.exceptionError),
                  duration: const Duration(seconds: 3),
                ),
              );
            }
          },
          builder: (signUpCtx, phoneState) {
            return Stack(
              children: [
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      FormLabel(ctx: context, text: "Phone number"),
                      EditPhoneNumberInput(
                        phoneNumberCont: phoneNumberCont,
                        onChanged: (phone) {
                          context
                              .read<PhoneCubit>()
                              .phoneNumberChanged(phone.completeNumber);
                          context
                              .read<PhoneCubit>()
                              .countryCodeChanged(phone.countryCode);
                          context
                              .read<PhoneCubit>()
                              .countryISOCodeChanged(phone.countryISOCode);
                        },
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        width: double.infinity,
                        child: MainButton(
                          onPressed: context
                                      .read<AuthenticationBloc>()
                                      .state
                                      .user
                                      .phoneNumber !=
                                  context
                                      .read<PhoneCubit>()
                                      .state
                                      .phoneNumber
                                      .value
                              ? () async {
                                  if (_formKey.currentState!.validate()) {
                                    context.read<PhoneCubit>().sendPhoneOTP();
                                  }
                                }
                              : null,
                          text: 'Continue',
                        ),
                      ),
                    ],
                  ).px20().pOnly(bottom: 20),
                ),
                if (phoneState.status == FormzSubmissionStatus.inProgress)
                  Container(
                    height: deviceSize.height,
                    width: double.infinity,
                    padding: EdgeInsets.only(top: deviceSize.height * .4),
                    alignment: Alignment.topCenter,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(.8),
                    ),
                    child: const CircularProgressIndicator(),
                  )
              ],
            );
          },
        ),
      ),
    );
  }
}
