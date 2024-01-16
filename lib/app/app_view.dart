import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../utils/firebase_events_logger.dart';
import '../utils/navigator.dart';
import '../utils/no_scroll_effect.dart';
import '../utils/router_generator.dart';
import 'auth/bloc/auth_bloc.dart';
import 'auth/data/auth_repository.dart';
import 'email_verification/verify_email_page.dart';
import 'error_page/error_page.dart';
import 'first_time_page/first_time_page.dart';
import 'login/login_page.dart';
import 'phone_verification/verify_phone_page.dart';
import 'root/root_page.dart';
import 'root/splash_page.dart';
import 'theme.dart';
import 'user/blocked_user_page.dart';
import 'user/enum/user.enums.dart';

class AppView extends StatefulWidget {
  const AppView({super.key});

  @override
  State<AppView> createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState get _navigator => _navigatorKey.currentState!;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: _navigatorKey,
      theme: AppTheme.lightTheme,
      themeMode: ThemeMode.light,
      builder: (context, child) {
        return ScrollConfiguration(
          behavior: NoScrollEffect(),
          child: MultiBlocListener(
            listeners: [
              BlocListener<AuthenticationBloc, AuthenticationState>(
                listener: (context, state) {
                  switch (state.status) {
                    case AuthenticationStatus.firstTime:
                      navigatorStatePushAndRemoveUntil(
                        _navigator,
                        const FirstTimePage(),
                      );
                      break;
                    case AuthenticationStatus.authenticated:
                      if (state.user.status == UserStatusEnum.BLOCKED) {
                        analyticsBlockedUserEvent();
                        analyticsUserTypeLogger(
                            userType: "prospective_tutor");
                        navigatorStatePushAndRemoveUntil(
                          _navigator,
                          const BlockedUserPage(),
                        );
                      } else if (state.user.phoneVerified == null ||
                          state.user.phoneVerified == false) {
                        analyticsPhoneVerificationEvent();
                        navigatorStatePushAndRemoveUntil(
                          _navigator,
                          const VerifyPhonePage(),
                        );
                      } else if (state.user.emailVerified == null ||
                          state.user.emailVerified == false) {
                        analyticsEmailVerificationEvent();
                        analyticsUserTypeLogger(
                            userType: "prospective_tutor");
                        navigatorStatePushAndRemoveUntil(
                          _navigator,
                          const VerifyEmailPage(),
                        );
                      } else if (state.user.role != UserRoleEnum.TUTOR) {

                      } else if (state.user.role == UserRoleEnum.TUTOR) {

                        navigatorStatePushAndRemoveUntil(
                          _navigator,
                          const RootPage(),
                        );

                      }
                      break;
                    case AuthenticationStatus.unauthenticated:
                      navigatorStatePushAndRemoveUntil(
                        _navigator,
                        const LoginPage(),
                      );
                      break;
                    case AuthenticationStatus.unknown:
                      break;
                    case AuthenticationStatus.error:
                      navigatorStatePushAndRemoveUntil(
                        _navigator,
                        const ErrorPage(),
                      );
                      break;
                  }
                },
              ),
            ],
            child: child!,
          ),
        );
      },
      home: const SplashPage(),
      initialRoute: "splash",
      onGenerateRoute: RouterGenerator.generateRoute,
    );
  }
}
