import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../auth/bloc/auth_bloc.dart';

class FirstTimePage extends StatelessWidget {
  const FirstTimePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            context.read<AuthenticationBloc>().add(AuthenticationSetFirstTime());
          },
          child: Text("Continue"),
        ),
      ),
    );
  }
}
