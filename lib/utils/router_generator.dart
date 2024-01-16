import 'package:flutter/material.dart';

import '../app/app_view.dart';
import '../app/first_time_page/first_time_page.dart';
import '../app/login/view/login_page.dart';
import '../app/phone_verification/forgot_password_page.dart';
import '../app/reset_password/reset_password_page.dart';
import '../app/root/root_page.dart';
import '../app/root/splash_page.dart';
import '../app/sign_up/view/sign_up_page.dart';
import '../constants/constants.dart';

class RouterGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.firstRoute:
        return PageRouteBuilder(
          pageBuilder: (context, animation1, animation2) => const AppView(),
          transitionDuration: const Duration(seconds: 0),
        );

      case AppRoutes.homeRoute:
        return PageRouteBuilder(
          pageBuilder: (context, animation1, animation2) => const RootPage(),
          transitionDuration: const Duration(seconds: 0),
        );

      case '/':
        return PageRouteBuilder(
          pageBuilder: (context, animation1, animation2) => const RootPage(),
          transitionDuration: const Duration(seconds: 0),
        );

      case AppRoutes.splashRoute:
        return PageRouteBuilder(
          pageBuilder: (context, animation1, animation2) => const SplashPage(),
          transitionDuration: const Duration(seconds: 0),
        );

      case AppRoutes.loginRoute:
        return PageRouteBuilder(
          pageBuilder: (context, animation1, animation2) => const LoginPage(),
          transitionDuration: const Duration(seconds: 0),
        );

      case AppRoutes.signupRoute:
        return PageRouteBuilder(
          pageBuilder: (context, animation1, animation2) => const SignUpPage(),
          transitionDuration: const Duration(seconds: 0),
        );

      case AppRoutes.forgotPswdRoute:
        return PageRouteBuilder(
          pageBuilder: (context, animation1, animation2) =>
              const ForgotPasswordPage(),
          transitionDuration: const Duration(seconds: 0),
        );

      case AppRoutes.resetPswdRoute:
        return PageRouteBuilder(
          pageBuilder: (context, animation1, animation2) =>
              const ResetPasswordPage(),
          transitionDuration: const Duration(seconds: 0),
        );

      case AppRoutes.firstTime:
        return PageRouteBuilder(
          pageBuilder: (context, animation1, animation2) =>
              const FirstTimePage(),
          transitionDuration: const Duration(seconds: 0),
        );

      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation1, animation2) =>
          const Scaffold(body: Center(child: Text('ERROR'))),
      transitionDuration: const Duration(seconds: 0),
    );
  }
}
