import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../utils/input_validators.dart';
import '../../utils/navigator.dart';
import '../auth/bloc/auth_bloc.dart';
import '../root/root_page.dart';
import '../widgets/app_bar/only_logo_app_bar.dart';
import '../widgets/buttons/main_button.dart';
import '../widgets/inputs/text_input_field.dart';
import '../widgets/progress_indicator_backdrop.dart';
import 'bloc/email_cubit.dart';
import 'email_otp_page.dart';

class VerifyEmailPage extends StatefulWidget {
  const VerifyEmailPage({super.key});

  @override
  State<VerifyEmailPage> createState() => _VerifyEmailPageState();
}

class _VerifyEmailPageState extends State<VerifyEmailPage> {
  TextEditingController emailCont = TextEditingController();
  bool isValidEmail = false;
  String emailText = "";

  @override
  void initState() {
    if (context.read<AuthenticationBloc>().state.user.email != null) {
      emailCont.text = context.read<AuthenticationBloc>().state.user.email!;
      emailText = context.read<AuthenticationBloc>().state.user.email!;
      isValidEmail = true;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EmailCubit, EmailState>(
      listener: (ctx, emailState) {
        if (emailState is EmailAuthCodeSent) {
          navigatorPush(
              context,
              EmailOtpPage(
                email: emailText,
                token: emailState.token,
              ));
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Verification code has been sent to your email."),
              duration: Duration(seconds: 3),
            ),
          );
        }
        if (emailState is EmailSuccessful) {
          navigatorPush(context, const RootPage());
          context
              .read<AuthenticationBloc>()
              .add(AuthenticationReFetchUserChanged());
        }
        if (emailState is EmailVerificationFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(emailState.message),
              duration: Duration(seconds: 3),
            ),
          );
        }
        if (emailState is EmailNotVerified) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                "Email not verified. Please check your email again.",
              ),
              duration: Duration(seconds: 3),
            ),
          );
        }
      },
      builder: (ctx, emailState) {
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
                        "Verify your email address",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextInputField(
                        validator: (value) =>
                            FormValidator.validateEmail(value),
                        controller: emailCont,
                        keyboardType: TextInputType.emailAddress,
                        onChanged: (email) {
                          setState(() {
                            isValidEmail = EmailUtils.isEmail(emailCont.text);
                          });
                        },
                        hintText: "email@gmail.com",
                        prefixIcon: const Icon(Icons.alternate_email_rounded),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        child: MainButton(
                          onPressed: isValidEmail
                              ? () {
                                  context.read<EmailCubit>().sendEmailOTP(
                                      emailCont.text.toLowerCase().trim());
                                  setState(() {
                                    emailText =
                                        emailCont.text.toLowerCase().trim();
                                  });
                                }
                              : null,
                          text: "Send verification code",
                        ),
                      ),
                      const SizedBox(height: 20),
                      if (emailState is EmailAuthCodeSent)
                        const Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "We have sent email verification link on your email. Please check your email and insert the code sent to verify your email address.",
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              "If your email is incorrect you can update it here!",
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
              ),
              if (emailState is EmailLoading) const ProgressIndicatorBackdrop(),
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
