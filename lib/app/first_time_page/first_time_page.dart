import 'package:flutter/material.dart';

class FirstTimePage extends StatelessWidget {
  const FirstTimePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
          },
          child: Text("Continue"),
        ),
      ),
    );
  }
}