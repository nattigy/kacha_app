import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constants/app_images.dart';
import '../widgets/app_bar/only_logo_app_bar.dart';
import '../widgets/auth_page_image.dart';
import '../widgets/buttons/main_button.dart';
import '../widgets/cards/max_width.dart';
import '../widgets/inputs/otp_input.dart';
import '../widgets/progress_indicator_backdrop.dart';
import '../widgets/text/header-text.dart';
import 'bloc/email_cubit.dart';

class EmailOtpPage extends StatefulWidget {
  final String email;
  final String token;

  const EmailOtpPage({super.key, required this.email, required this.token});

  @override
  State<EmailOtpPage> createState() => _EmailOtpPageState();
}

class _EmailOtpPageState extends State<EmailOtpPage>
    with SingleTickerProviderStateMixin {
  AnimationController? _animationController;
  int levelClock = 2 * 60;

  late Timer _timer;

  bool resendButton = false;

  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this, duration: Duration(seconds: levelClock));

    _animationController!.forward();
    buttonTimer();
    super.initState();
  }

  Timer buttonTimer() {
    _timer = Timer(
      const Duration(seconds: 120),
      () {
        if (_animationController != null) {
          setState(() {
            if (resendButton == false) {
              resendButton = true;
            } else {
              resendButton = false;
            }
          });
        }
      },
    );
    return _timer;
  }

  @override
  void dispose() {
    _animationController!.dispose();
    _timer.cancel();
    super.dispose();
  }

  TextEditingController otpController = TextEditingController();
  FocusNode otpFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EmailCubit, EmailState>(
      builder: (phoneCtx, emailState) {
        return Scaffold(
          appBar: const PreferredSize(
            preferredSize: Size.fromHeight(60),
            child: OnlyLogoAppBar(),
          ),
          body: MaxWidth(
            child: Stack(
              children: [
                SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const AuthPageImage(image: AppImages.otpImage),
                        HeaderText(ctx: context, text: "Enter OTP"),
                        Text(
                          "We've sent a 6 digit verification code to your email.",
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: 10),
                        OtpInput(
                          controller: otpController,
                          focusNode: otpFocusNode,
                          onCompleted: (pin) {},
                        ),
                        if (emailState is! EmailVerificationFailure)
                          const SizedBox(height: 15),
                        if (emailState is EmailVerificationFailure)
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Text(
                              'Verification failed, please retry. And check if your email is correct',
                              style: TextStyle(
                                color: Colors.red.shade600,
                              ),
                            ),
                          ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Resend code after: "),
                            Countdown(
                              animation: StepTween(
                                begin: levelClock,
                                end: 0,
                              ).animate(_animationController!),
                            ),
                          ],
                        ),
                        const SizedBox(height: 15),
                        SizedBox(
                          width: double.infinity,
                          child: MainButton(
                            text: "Verify code",
                            onPressed: () {
                              context.read<EmailCubit>().verifyEmailOTP(
                                  otpController.text, widget.token);
                            },
                          ),
                        ),
                        resendButton == true
                            ? Align(
                                alignment: Alignment.centerRight,
                                child: TextButton(
                                  onPressed: () async {
                                    _animationController!.reset();
                                    _animationController!.forward();
                                    context
                                        .read<EmailCubit>()
                                        .sendEmailOTP(widget.email);
                                    setState(() {
                                      resendButton = false;
                                    });
                                  },
                                  child: const Text("Re-send code"),
                                ),
                              )
                            : const SizedBox(),
                      ],
                    ),
                  ),
                ),
                if (emailState is EmailLoading || emailState is EmailVerifying)
                  const ProgressIndicatorBackdrop()
              ],
            ),
          ),
        );
      },
    );
  }
}

class Countdown extends AnimatedWidget {
  const Countdown({Key? key, required this.animation})
      : super(key: key, listenable: animation);
  final Animation<int> animation;

  @override
  build(BuildContext context) {
    Duration clockTimer = Duration(seconds: animation.value);

    String timerText =
        '${clockTimer.inMinutes.remainder(60).toString()}:${clockTimer.inSeconds.remainder(60).toString().padLeft(2, '0')}';
    return Text(
      timerText,
      style: const TextStyle(fontSize: 18),
    );
  }
}
