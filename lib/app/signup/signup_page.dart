import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '../../../constants/app_images.dart';
import '../../../utils/navigator.dart';
import '../login/login_page.dart';
import '../widgets/app_bar/only_logo_app_bar.dart';
import '../widgets/auth_page_image.dart';
import '../widgets/buttons/main_button.dart';
import '../widgets/buttons/main_outline_button.dart';
import '../widgets/cards/max_width.dart';
import '../widgets/progress_indicator_backdrop.dart';
import '../widgets/text/header-text.dart';
import 'bloc/sign_up.cubit.dart';
import 'widgets/widgets.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  int step = 1;

  void changeStep(int val) {
    if (1 <= step + val && step + val <= 2) {
      setState(() {
        step += val;
      });
    }
  }

  final _formKey = GlobalKey<FormState>();
  TextEditingController firstNameCont = TextEditingController();
  TextEditingController middleNameCont = TextEditingController();
  TextEditingController lastNameCont = TextEditingController();
  TextEditingController genderCont = TextEditingController();
  TextEditingController emailCont = TextEditingController();
  TextEditingController phoneNumberCont = TextEditingController();
  TextEditingController passwordCont = TextEditingController();
  TextEditingController confirmPasswordCont = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(55),
        child: OnlyLogoAppBar(),
      ),
      body: MaxWidth(
        child: BlocBuilder<SignUpCubit, SignUpState>(
          builder: (ctx, signUpState) {
            return MultiBlocListener(
              listeners: [
                BlocListener<SignUpCubit, SignUpState>(
                  listener: (context, state) {
                    if (state.status.isFailure) {
                      ScaffoldMessenger.of(context)
                        ..hideCurrentSnackBar()
                        ..showSnackBar(
                          SnackBar(
                            content: Text(state.exceptionError),
                            duration: const Duration(seconds: 3),
                          ),
                        );
                    }
                  },
                ),
              ],
              child: Stack(
                children: [
                  SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: buildForm(context, signUpState),
                    ),
                  ),
                  if (signUpState.status.isInProgress)
                    const ProgressIndicatorBackdrop()
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Form buildForm(BuildContext context, signUpState) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          const AuthPageImage(image: AppImages.signupImage),
          SignUpProgressIndicator(step: step),
          const SizedBox(height: 10),
          HeaderText(ctx: context, text: "Sign up"),
          const SizedBox(height: 20),
          if (step == 1) ...[
            FirstNameSignupInput(firstNameCont: firstNameCont),
            const SizedBox(height: 20),
            MiddleNameSignupInput(middleNameCont: middleNameCont),
            const SizedBox(height: 20),
            LastNameSignupInput(lastNameCont: lastNameCont),
            const SizedBox(height: 20),
            GenderSignupInput(
              genderCont: genderCont,
              genderValue: genderCont.text,
            ),
          ],
          if (step == 2) ...[
            EmailSignupInput(emailCont: emailCont),
            const SizedBox(height: 20),
            PhoneNumberSignupInput(
              phoneNumberCont: phoneNumberCont,
            ),
            PasswordSignupInput(passwordCont: passwordCont),
            const SizedBox(height: 20),
            ConfirmPasswordSignupInput(
              confirmPasswordCont: confirmPasswordCont,
              password: passwordCont,
            ),
          ],
          const SizedBox(height: 30),
          buildButtonRow(context, signUpState),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Already have an account? "),
              TextButton(
                onPressed: () {
                  navigatorPushReplacement(context, const LoginPage());
                },
                child: const Text("Login"),
              )
            ],
          ),
        ],
      ),
    );
  }

  Row buildButtonRow(BuildContext context, signUpState) {
    return Row(
      children: [
        Expanded(
          child: MainOutlineButton(
            onPressed: step == 1 ? null : () => changeStep(-1),
            text: "Back",
          ),
        ),
        const SizedBox(width: 10),
        if (step < 2)
          Expanded(
            child: MainButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  setState(() {
                    if (step == 2) {
                      return;
                    }
                    changeStep(1);
                  });
                }
              },
              text: "Next",
            ),
          ),
        if (step > 1)
          Expanded(
            child: SizedBox(
              width: double.infinity,
              child: MainButton(
                text: "Sign Up",
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    context.read<SignUpCubit>().submitSignUp();
                  }
                },
              ),
            ),
          ),
      ],
    );
  }
}
