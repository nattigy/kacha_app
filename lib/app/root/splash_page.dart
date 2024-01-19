import 'package:flutter/material.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  static Route<void> route() {
    return PageRouteBuilder(
      pageBuilder: (context, animation1, animation2) => const SplashPage(),
      transitionDuration: const Duration(seconds: 0),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
