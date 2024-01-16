import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '../../constants/app_images.dart';
import '../../utils/navigator.dart';
import '../phone_verification/forgot_password_page.dart';
import '../signup/signup_page.dart';
import '../widgets/app_bar/only_logo_app_bar.dart';
import '../widgets/auth_page_image.dart';
import '../widgets/buttons/main_button.dart';
import '../widgets/cards/max_width.dart';
import '../widgets/progress_indicator_backdrop.dart';
import '../widgets/text/header-text.dart';
import 'bloc/login_cubit.dart';
import 'widgets/widgets.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  TextEditingController phoneNumberCont = TextEditingController();
  TextEditingController passwordCont = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      builder: (ctx, loginState) {
        return Scaffold(
          appBar: const PreferredSize(
            preferredSize: Size.fromHeight(60),
            child: OnlyLogoAppBar(),
          ),
          body: SafeArea(
            child: MaxWidth(
              child: BlocListener<LoginCubit, LoginState>(
                listener: (loginCtx, loginState) {
                  if (loginState.status.isFailure) {
                    ScaffoldMessenger.of(context)
                      ..hideCurrentSnackBar()
                      ..showSnackBar(
                        SnackBar(
                          content: Text(loginState.exceptionError),
                          duration: const Duration(seconds: 3),
                        ),
                      );
                  }
                },
                child: Stack(
                  children: [
                    SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: buildForm(context),
                      ),
                    ),
                    if (loginState.status.isInProgress)
                      const ProgressIndicatorBackdrop()
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Form buildForm(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          const AuthPageImage(image: AppImages.loginImage),
          const SizedBox(height: 20),
          HeaderText(ctx: context, text: "Login"),
          const SizedBox(height: 20),
          LoginPhoneNumberInput(phoneNumberCont: phoneNumberCont),
          LoginPasswordInput(passwordCont: passwordCont),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () => navigatorPushReplacement(
                context,
                const ForgotPasswordPage(),
              ),
              style: ButtonStyle(
                padding: MaterialStateProperty.all(EdgeInsets.zero),
              ),
              child: const Text("Forgot Password?"),
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: MainButton(
              text: "Login",
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  context.read<LoginCubit>().submitLogin();
                }
              },
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Don't have an account?"),
              TextButton(
                onPressed: () => navigatorPushReplacement(
                  context,
                  const SignupPage(),
                ),
                child: const Text("Signup"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
