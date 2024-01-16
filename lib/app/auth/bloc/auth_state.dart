part of 'auth_bloc.dart';

class AuthenticationState extends Equatable {
  const AuthenticationState._({
    this.status = AuthenticationStatus.unknown,
    this.user = UserEntity.empty,
  });

  const AuthenticationState.unknown() : this._();

  const AuthenticationState.authenticated(UserEntity user)
      : this._(status: AuthenticationStatus.authenticated, user: user);

  const AuthenticationState.unauthenticated()
      : this._(status: AuthenticationStatus.unauthenticated);

  const AuthenticationState.firstTime()
      : this._(status: AuthenticationStatus.firstTime);

  const AuthenticationState.error()
      : this._(status: AuthenticationStatus.error);

  final AuthenticationStatus status;
  final UserEntity user;

  @override
  List<Object> get props => [status, user];
}
