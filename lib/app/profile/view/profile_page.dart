import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kacha_app/app/auth/bloc/app_bloc.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            context.read<AppBloc>().add(AppLogoutRequested());
          },
          child: Text("Logout"),
        ),
      ),
    );
  }
}
