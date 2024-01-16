import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app_view.dart';
import 'auth/bloc/auth_bloc.dart';
import 'auth/data/auth_repository.dart';
import 'edit_user/bloc/edit_user.cubit.dart';
import 'email_verification/bloc/email_cubit.dart';
import 'email_verification/data/email_repository.dart';
import 'login/bloc/login_cubit.dart';
import 'phone_verification/bloc/phone_cubit.dart';
import 'phone_verification/data/phone_repository.dart';
import 'root/bloc/navigation_bloc.dart';
import 'signup/bloc/sign_up.cubit.dart';
import 'user/bloc/users.bloc.dart';
import 'user/data/user.repository.dart';

class App extends StatefulWidget {
  App({super.key});

  final AuthenticationRepository authenticationRepository =
      AuthenticationRepository();
  final UserRepository userRepository = UserRepository();

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: widget.authenticationRepository),
        RepositoryProvider.value(value: widget.userRepository),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthenticationBloc>(
            create: (context) => AuthenticationBloc(
              authenticationRepository:
                  context.read<AuthenticationRepository>(),
            ),
          ),
          BlocProvider<UsersBloc>(
            create: (context) => UsersBloc(
              authenticationRepository:
                  context.read<AuthenticationRepository>(),
              userRepository: context.read<UserRepository>(),
            ),
          ),
          BlocProvider<LoginCubit>(
            create: (context) => LoginCubit(
              authenticationRepository:
                  RepositoryProvider.of<AuthenticationRepository>(context),
            ),
          ),
          BlocProvider<SignUpCubit>(
            create: (context) => SignUpCubit(
              authenticationRepository:
                  context.read<AuthenticationRepository>(),
            ),
          ),
          BlocProvider<PhoneCubit>(
            create: (context) => PhoneCubit(
              phoneRepository: PhoneRepository(
                  authenticationRepository:
                      context.read<AuthenticationRepository>()),
            ),
          ),
          BlocProvider<EmailCubit>(
            create: (context) => EmailCubit(
              emailRepository: EmailRepository(
                  authenticationRepository:
                      context.read<AuthenticationRepository>()),
            ),
          ),
          BlocProvider<NavigationBloc>(create: (context) => NavigationBloc()),
          BlocProvider<EditUserCubit>(
            create: (context) => EditUserCubit(
              userRepository: context.read<UserRepository>(),
            ),
          ),
        ],
        child: const AppView(),
      ),
    );
  }
}
