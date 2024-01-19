import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kacha_app/app/auth/bloc/app_bloc.dart';
import 'package:kacha_app/app/home/cubit/home.cubit.dart';
import 'package:kacha_app/app/login/login.dart';
import 'package:kacha_app/app/sign_up/sign_up.dart';
import 'package:kacha_app/app/upcoming/cubit/upcoming.cubit.dart';
import 'package:payment_repository/payment_repository.dart';

import 'app_view.dart';
import 'edit_user/bloc/edit_user.cubit.dart';
import 'root/bloc/navigation_bloc.dart';
import 'top_up/cubit/top_up.cubit.dart';
import 'user/bloc/users.bloc.dart';
import 'user/data/user.repository.dart';

class App extends StatefulWidget {
  App({
    required AuthenticationRepository authenticationRepository,
    super.key,
  }) : _authenticationRepository = authenticationRepository;

  final AuthenticationRepository _authenticationRepository;

  final UserRepository userRepository = UserRepository();
  final PaymentRepository paymentRepository = PaymentRepository();

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
        RepositoryProvider.value(value: widget.paymentRepository),
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
          BlocProvider<NavigationBloc>(create: (context) => NavigationBloc()),
          BlocProvider<HomeCubit>(
            create: (context) => HomeCubit(
              paymentRepository: context.read<PaymentRepository>(),
            )..loadHomeCard(),
          ),
          BlocProvider<UpcomingCubit>(
            create: (context) => UpcomingCubit(
              paymentRepository: context.read<PaymentRepository>(),
            )..loadUpcomingCard(),
          ),
          BlocProvider<TopUpCubit>(
            create: (context) => TopUpCubit(
              paymentRepository: context.read<PaymentRepository>(),
            ),
          ),
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
