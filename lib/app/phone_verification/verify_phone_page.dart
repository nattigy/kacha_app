import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '../../utils/navigator.dart';
import '../auth/bloc/auth_bloc.dart';
import '../root/root_page.dart';
import '../widgets/app_bar/only_logo_app_bar.dart';
import '../widgets/buttons/main_button.dart';
import '../widgets/progress_indicator_backdrop.dart';
import 'bloc/phone_cubit.dart';
import 'phone_otp_page.dart';
import 'widgets/phone_number_input.dart';

class VerifyPhonePage extends StatefulWidget {
  const VerifyPhonePage({super.key});

  @override
  State<VerifyPhonePage> createState() => _VerifyPhonePageState();
}

class _VerifyPhonePageState extends State<VerifyPhonePage> {
  TextEditingController phoneNumberCont = TextEditingController();
  String countryISOCode = "ET";
  String countryCode = "+251";

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
    return BlocConsumer<PhoneCubit, PhoneState>(
      listener: (ctx, phoneState) {
        if (phoneState.phoneCodeSent) {
          navigatorPush(context, PhoneOtpPage());
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content:
                  Text("Verification code has been sent to your phone number."),
              duration: Duration(seconds: 3),
            ),
          );
        }
        if (phoneState.status == FormzSubmissionStatus.success) {
          navigatorPush(context, const RootPage());
          context
              .read<AuthenticationBloc>()
              .add(AuthenticationReFetchUserChanged());
        }
        if (phoneState.status == FormzSubmissionStatus.failure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(phoneState.exceptionError),
              duration: Duration(seconds: 3),
            ),
          );
        }
      },
      builder: (ctx, phoneState) {
        return Scaffold(
          appBar: const PreferredSize(
            preferredSize: Size.fromHeight(55),
            child: OnlyLogoAppBar(),
          ),
          body: Stack(
            children: [
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      const SizedBox(height: 100),
                      const Icon(Icons.mark_email_read_outlined, size: 100),
                      const Text(
                        "Verify your phone number",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 10),
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
                      const SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        child: MainButton(
                          onPressed: () {
                            context.read<PhoneCubit>().sendPhoneOTP();
                          },
                          text: "Send OTP code",
                        ),
                      ),
                      const SizedBox(height: 20),
                      if (phoneState.phoneCodeSent)
                        const Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "We have sent an OTP code to your phone number. Please check your messages and insert the code sent to verify your phone number.",
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              "If your phone number is incorrect you can update it here!",
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
              ),
              if (phoneState.status == FormzSubmissionStatus.inProgress)
                const ProgressIndicatorBackdrop(),
              Align(
                alignment: Alignment.bottomCenter,
                child: TextButton(
                  onPressed: () {
                    context
                        .read<AuthenticationBloc>()
                        .add(AuthenticationLogoutRequested());
                  },
                  child: const Text("Cancel and logout?"),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
