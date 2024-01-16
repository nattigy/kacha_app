import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kacha_app/app/auth/bloc/app_bloc.dart';
import 'package:kacha_app/app/login/login.dart';
import 'package:kacha_app/app/sign_up/sign_up.dart';

import 'app_view.dart';
import 'edit_user/bloc/edit_user.cubit.dart';
import 'email_verification/bloc/email_cubit.dart';
import 'email_verification/data/email_repository.dart';
import 'phone_verification/bloc/phone_cubit.dart';
import 'phone_verification/data/phone_repository.dart';
import 'root/bloc/navigation_bloc.dart';
import 'user/bloc/users.bloc.dart';
import 'user/data/user.repository.dart';

class App extends StatefulWidget {
  App({
    required AuthenticationRepository authenticationRepository,
    super.key,
  }) : _authenticationRepository = authenticationRepository;

  final AuthenticationRepository _authenticationRepository;

  final UserRepository userRepository = UserRepository();

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: widget._authenticationRepository),
        RepositoryProvider.value(value: widget.userRepository),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AppBloc>(
            create: (context) => AppBloc(
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
              context.read<AuthenticationRepository>(),
            ),
          ),
          BlocProvider<SignUpCubit>(
            create: (context) => SignUpCubit(
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
