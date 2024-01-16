import 'package:authentication_repository/authentication_repository.dart';
import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kacha_app/app/app.dart';
import 'package:kacha_app/app/view/splash_page.dart';
import 'package:kacha_app/home/home.dart';
import 'package:kacha_app/login/login.dart';
import 'package:kacha_app/theme.dart';

import '../../utils/navigator.dart';
import '../../utils/no_scroll_effect.dart';

class App extends StatelessWidget {
  const App({
    required AuthenticationRepository authenticationRepository,
    super.key,
  }) : _authenticationRepository = authenticationRepository;

  final AuthenticationRepository _authenticationRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: _authenticationRepository,
      child: BlocProvider(
        create: (_) => AppBloc(
          authenticationRepository: _authenticationRepository,
        ),
        child: AppView(),
      ),
    );
  }
}

class AppView extends StatelessWidget {
   AppView({super.key});

  final _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState get _navigator => _navigatorKey.currentState!;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: theme,
      debugShowCheckedModeBanner: false,
      navigatorKey: _navigatorKey,
      builder: (context, child) {
        return ScrollConfiguration(
          behavior: NoScrollEffect(),
          child: MultiBlocListener(
            listeners: [
              BlocListener<AuthenticationBloc, AuthenticationState>(
                listener: (context, state) {
                  switch (state.status) {
                    case AuthenticationStatus.authenticated:
                      _navigator.pushNamed(AppRoutes.homePage);
                      // navigatorStatePushAndRemoveUntil(
                      //   _navigator,
                      //   const HomePage(),
                      // );
                      break;
                    case AuthenticationStatus.unauthenticated:
                      _navigator.pushNamed(AppRoutes.loginRoute);
                      // navigatorStatePushAndRemoveUntil(
                      //   _navigator,
                      //   const LoginPage(),
                      // );
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
      initialRoute: AppRoutes.splashRoute,
      onGenerateRoute: RouterGenerator.generateRoute,
    );
  }
}
