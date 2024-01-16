import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kacha_app/app/auth/bloc/app_bloc.dart';

import '../utils/navigator.dart';
import '../utils/no_scroll_effect.dart';
import '../utils/router_generator.dart';
import 'login/view/login_page.dart';
import 'root/root_page.dart';
import 'root/splash_page.dart';
import 'theme.dart';

class AppView extends StatefulWidget {
  const AppView({super.key});

  @override
  State<AppView> createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState get _navigator => _navigatorKey.currentState!;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: _navigatorKey,
      theme: AppTheme.lightTheme,
      themeMode: ThemeMode.light,
      builder: (context, child) {
        return ScrollConfiguration(
          behavior: NoScrollEffect(),
          child: MultiBlocListener(
            listeners: [
              BlocListener<AppBloc, AppState>(
                listener: (context, state) {
                  switch (state.status) {
                    case AppStatus.authenticated:
                      navigatorStatePushAndRemoveUntil(
                        _navigator,
                        const RootPage(),
                      );
                      break;
                    case AppStatus.unauthenticated:
                      navigatorStatePushAndRemoveUntil(
                        _navigator,
                        const LoginPage(),
                      );
                      break;
                  }
                },
              ),
            ],
            child: child!,
          ),
        );
      },
      home: const SplashPage(),
      initialRoute: "splash",
      onGenerateRoute: RouterGenerator.generateRoute,
    );
  }
}
