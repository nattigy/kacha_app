import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kacha_app/app/auth/bloc/app_bloc.dart';

import '../../../constants/constants.dart';

class OnlyLogoAppBar extends StatelessWidget {
  const OnlyLogoAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(
      builder: (context, state) {
        return AppBar(
          centerTitle: true,
          title: Container(
            constraints: const BoxConstraints(maxWidth: 300),
            child: SizedBox(
              width: 200,
              child: Image.asset(AppImages.appLogo),
            ),
          ),
        );
      },
    );
  }
}
