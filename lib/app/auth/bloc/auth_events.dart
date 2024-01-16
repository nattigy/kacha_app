part of 'auth_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class AuthenticationStatusChanged extends AuthenticationEvent {
  final AuthenticationStatus status;

  const AuthenticationStatusChanged(this.status);

  @override
  List<Object> get props => [status];
}

class AuthenticationReFetchUserChanged extends AuthenticationEvent {}

class AuthenticationSetFirstTime extends AuthenticationEvent {}

class AuthenticationLogoutRequested extends AuthenticationEvent {}
