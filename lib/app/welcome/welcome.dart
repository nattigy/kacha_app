import 'package:flutter/material.dart';
import 'package:kacha_app/app/login/view/login_page.dart';

import '../../utils/navigator.dart';

class Welcome extends StatelessWidget {
  const Welcome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Welcome"),
            ElevatedButton(
              onPressed: () {
                navigatorPushAndRemoveUntil(
                  context,
                  const LoginPage(),
                );
              },
              child: Text("Login"),
            )
          ],
        ),
      ),
    );
  }
}
