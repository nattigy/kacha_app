import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../utils/input_validators.dart';
import '../../utils/navigator.dart';
import '../auth/bloc/auth_bloc.dart';
import '../widgets/buttons/main_button.dart';
import '../widgets/inputs/text_input_field.dart';
import '../widgets/text/form-label-text.dart';
import 'bloc/email_cubit.dart';
import 'email_otp_page.dart';

class EditEmailPage extends StatefulWidget {
  const EditEmailPage({super.key});

  @override
  State<EditEmailPage> createState() => _EditEmailPageState();
}

class _EditEmailPageState extends State<EditEmailPage> {
  TextEditingController emailCont = TextEditingController();
  bool isValidEmail = false;

  @override
  void initState() {
    if (context.read<AuthenticationBloc>().state.user.email != null) {
      emailCont.text = context.read<AuthenticationBloc>().state.user.email!;
      isValidEmail = true;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;

    return BlocConsumer<EmailCubit, EmailState>(
      listener: (ctx, emailState) {
        if (emailState is EmailAuthCodeSent) {
          navigatorPush(
              context,
              EmailOtpPage(
                email: emailCont.text,
                token: emailState.token,
              ));
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Verification link has been sent to your email."),
              duration: Duration(seconds: 3),
            ),
          );
        }
        if (emailState is EmailSuccessful) {
          // navigatorPush(context, RootPage());
          context
              .read<AuthenticationBloc>()
              .add(AuthenticationReFetchUserChanged());
        }
        if (emailState is EmailVerificationFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(emailState.message),
              duration: const Duration(seconds: 3),
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
      builder: (ctx, emailState) => Scaffold(
        appBar: AppBar(title: const Text("Edit phone number")),
        body: SafeArea(
          child: Stack(
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FormLabel(ctx: context, text: "Email"),
                    TextInputField(
                      validator: (value) => FormValidator.validateEmail(value),
                      prefixIcon: const Icon(FontAwesomeIcons.at, size: 16),
                      hintText: "email@gmail.com",
                      controller: emailCont,
                      keyboardType: TextInputType.emailAddress,
                      onChanged: (email) {
                        setState(() {
                          isValidEmail = EmailUtils.isEmail(emailCont.text);
                        });
                      },
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: double.infinity,
                      child: MainButton(
                        onPressed: isValidEmail
                            ? () => context
                                .read<EmailCubit>()
                                .sendEmailOTP(emailCont.text.toLowerCase().trim())
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
              if (emailState is EmailLoading)
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
          ),
        ),
      ),
    );
  }
}
