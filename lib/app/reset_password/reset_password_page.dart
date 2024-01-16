import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../constants/app_images.dart';
import '../widgets/app_bar/only_logo_app_bar.dart';
import '../widgets/auth_page_image.dart';
import '../widgets/buttons/main_button.dart';
import '../widgets/cards/max_width.dart';
import '../widgets/progress_indicator_backdrop.dart';
import '../widgets/text/form-label-text.dart';
import '../widgets/text/header-text.dart';
import 'bloc/reset_password_cubit.dart';
import 'data/reset_password_repository.dart';
import 'widgets/widgets.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController passwordCont = TextEditingController();
  TextEditingController confirmPasswordCont = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(55),
        child: OnlyLogoAppBar(),
      ),
      body: MaxWidth(
        child: BlocProvider<ResetPasswordCubit>(
          create: (context) {
            return ResetPasswordCubit(
              resetPasswordRepository: ResetPasswordRepository(
                authenticationRepository:
                    RepositoryProvider.of<AuthenticationRepository>(context),
              ),
            );
          },
          child: BlocConsumer<ResetPasswordCubit, ResetPasswordState>(
            listener: (context, state) {
              if (state.status.isFailure) {
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(
                    SnackBar(content: Text(state.exceptionError)),
                  );
              }
              if (state.status.isSuccess) {
                // context
                //     .read<AuthenticationBloc>()
                //     .add(AuthenticationReFetchUserChanged());
              }
            },
            builder: (context, state) => Stack(
              children: [
                SingleChildScrollView(child: buildForm(context)),
                if (state.status.isInProgress) const ProgressIndicatorBackdrop()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Form buildForm(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const AuthPageImage(image: AppImages.resetPswdImage),
          HeaderText(ctx: context, text: "Reset Password?"),
          FormLabel(ctx: context, text: "Enter your new password"),
          ResetPasswordInput(passwordCont: passwordCont),
          FormLabel(ctx: context, text: "Confirm Password"),
          ResetPasswordConfirmPasswordInput(
            confirmPasswordCont: confirmPasswordCont,
          ),
          SizedBox(
            width: double.infinity,
            child: MainButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  context.read<ResetPasswordCubit>().resetPassword();
                }
              },
              text: 'Reset',
            ),
          ).py16(),
        ],
      ).px20().pOnly(bottom: 20),
    );
  }
}
