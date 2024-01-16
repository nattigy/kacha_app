import 'package:flutter/material.dart';

import '../widgets/app_bar/only_logo_app_bar.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: OnlyLogoAppBar(),
      ),
      body: Stack(
        children: [
          Center(
            child: TextButton(
              onPressed: () {
                // context
                //     .read<AuthenticationBloc>()
                //     .add(AuthenticationReFetchUserChanged());
              },
              child: const Text("Some error occurred, please retry"),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: TextButton(
              onPressed: () {
                // context
                //     .read<AuthenticationBloc>()
                //     .add(AuthenticationLogoutRequested());
              },
              child: const Text("logout?"),
            ),
          ),
        ],
      ),
    );
  }
}
