import 'package:flutter/material.dart';
import 'package:kacha_app/app/view/splash_page.dart';
import 'package:kacha_app/home/home.dart';
import 'package:kacha_app/login/login.dart';
import 'package:kacha_app/sign_up/sign_up.dart';

import '../../forgot_password/view/forgot_password.dart';
import '../view/app.dart';

class AppRoutes {
  static const splashRoute = 'splash';
  static const loginRoute = 'login';
  static const signupRoute = 'signup';
  static const forgotPswdRoute = 'forgotPassword';
  static const resetPswdRoute = 'resetPassword';
  static const homePage = 'home';
}

class RouterGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case "/":
        return PageRouteBuilder(
          pageBuilder: (context, animation1, animation2) => AppView(),
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

      case AppRoutes.splashRoute:
        return PageRouteBuilder(
          pageBuilder: (context, animation1, animation2) => const SplashPage(),
          transitionDuration: const Duration(seconds: 0),
        );

      case AppRoutes.homePage:
        return PageRouteBuilder(
          pageBuilder: (context, animation1, animation2) => const HomePage(),
          transitionDuration: const Duration(seconds: 0),
        );

      case AppRoutes.forgotPswdRoute:
        return PageRouteBuilder(
          pageBuilder: (context, animation1, animation2) =>
          const ForgotPasswordPage(),
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
