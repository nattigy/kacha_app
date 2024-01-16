import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '../../constants/app_images.dart';
import '../../utils/navigator.dart';
import '../login/login_page.dart';
import '../widgets/app_bar/only_logo_app_bar.dart';
import '../widgets/auth_page_image.dart';
import '../widgets/buttons/main_button.dart';
import '../widgets/buttons/main_outline_button.dart';
import '../widgets/cards/max_width.dart';
import '../widgets/progress_indicator_backdrop.dart';
import '../widgets/text/header-text.dart';
import 'bloc/phone_cubit.dart';
import 'phone_otp_page.dart';
import 'widgets/phone_number_input.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController phoneNumberCont = TextEditingController();

  @override
  void initState() {
    context.read<PhoneCubit>().countryCodeChanged("+251");
    context.read<PhoneCubit>().countryISOCodeChanged("ET");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(55),
        child: OnlyLogoAppBar(),
      ),
      body: MaxWidth(
        child: BlocConsumer<PhoneCubit, PhoneState>(
          listener: (context, phoneState) {
            if (phoneState.status == FormzSubmissionStatus.failure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(phoneState.exceptionError)),
              );
            }
            if (phoneState.phoneCodeSent) {
              navigatorPush(
                context,
                PhoneOtpPage(isFromForgotPass: true),
              );
            }
          },
          builder: (context, phoneState) {
            return Stack(
              children: [
                SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: buildForm(context),
                  ),
                ),
                if (phoneState.status == FormzSubmissionStatus.inProgress)
                  const ProgressIndicatorBackdrop()
              ],
            );
          },
        ),
      ),
    );
  }

  Form buildForm(BuildContext context) {
    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const AuthPageImage(image: AppImages.forgotPswdImage),
          HeaderText(ctx: context, text: "Forgot Password?"),
          Text(
            "Please enter the phone number associated with your account.",
            style: Theme.of(context).textTheme.titleMedium,
          ),
          EditPhoneNumberInput(
            phoneNumberCont: phoneNumberCont,
            onChanged: (phone) {
              context
                  .read<PhoneCubit>()
                  .phoneNumberChanged(phone.completeNumber);
              context.read<PhoneCubit>().countryCodeChanged(phone.countryCode);
              context
                  .read<PhoneCubit>()
                  .countryISOCodeChanged(phone.countryISOCode);
            },
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: MainOutlineButton(
                  onPressed: () {
                    navigatorPushReplacement(
                      context,
                      const LoginPage(),
                    );
                  },
                  text: "Cancel",
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: MainButton(
                  text: "Send code",
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      context.read<PhoneCubit>().forgotPassword();
                    }
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
