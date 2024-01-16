import 'package:flutter/material.dart';

class WelComePage extends StatelessWidget {
  const WelComePage({super.key});

  static Page<void> page() => const MaterialPage<void>(child: WelComePage());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Welcome"),
              Image.asset(
                'assets/bloc_logo_small.png',
                height: 120,
              ),
              ElevatedButton(
                onPressed: () {},
                child: Text("Login"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
