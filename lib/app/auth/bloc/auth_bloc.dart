import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../user/entity/user.entity.dart';
import '../data/auth_repository.dart';

part 'auth_events.dart';
part 'auth_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc({
    required AuthenticationRepository authenticationRepository,
  })  : _authenticationRepository = authenticationRepository,
        super(const AuthenticationState.unknown()) {
    on<AuthenticationStatusChanged>(_onAuthenticationStatusChanged);
    on<AuthenticationLogoutRequested>(_onAuthenticationLogoutRequested);
    on<AuthenticationReFetchUserChanged>(_onAuthenticationReFetchUserRequested);
    on<AuthenticationSetFirstTime>(_onSetFirstTime);
    _authenticationStatusSubscription = _authenticationRepository.status.listen(
      (status) => add(AuthenticationStatusChanged(status)),
    );
  }

  final AuthenticationRepository _authenticationRepository;
  late StreamSubscription<AuthenticationStatus>
      _authenticationStatusSubscription;

  void pauseSubscription() {
    if (!_authenticationStatusSubscription.isPaused) {
      _authenticationStatusSubscription.pause();
    }
  }

  void resumeSubscription() {
    if (_authenticationStatusSubscription.isPaused) {
      _authenticationStatusSubscription.resume();
    }
  }

  @override
  Future<void> close() {
    _authenticationStatusSubscription.cancel();
    _authenticationRepository.dispose();
    return super.close();
  }

  Future<void> _onAuthenticationStatusChanged(
    AuthenticationStatusChanged event,
    Emitter<AuthenticationState> emit,
  ) async {
    switch (event.status) {
      case AuthenticationStatus.firstTime:
        return emit(const AuthenticationState.firstTime());
      case AuthenticationStatus.unauthenticated:
        return emit(const AuthenticationState.unauthenticated());
      case AuthenticationStatus.authenticated:
        try {
          final user = await _authenticationRepository.getUser();
          if (user != null) {
            return emit(AuthenticationState.authenticated(user));
          }
        } catch (e) {
          if (e == "Unauthorized" ||
              e == "Unauthorized!" ||
              e == "SessionExpired!") {
            _authenticationRepository.logOut();
          }
        }
        break;
      case AuthenticationStatus.unknown:
        return emit(const AuthenticationState.unknown());
      case AuthenticationStatus.error:
        return emit(const AuthenticationState.error());
    }
  }

  void _onAuthenticationLogoutRequested(
    AuthenticationLogoutRequested event,
    Emitter<AuthenticationState> emit,
  ) {
    _authenticationRepository.logOut();
  }

  void _onSetFirstTime(
      AuthenticationSetFirstTime event,
      Emitter<AuthenticationState> emit,
      ) {
    _authenticationRepository.setFirstTime();
  }

  void _onAuthenticationReFetchUserRequested(
    AuthenticationReFetchUserChanged event,
    Emitter<AuthenticationState> emit,
  ) async {
    try {
      UserEntity? user = await _authenticationRepository.getUser();
      if (user != null) {
        return emit(AuthenticationState.authenticated(user));
      }
      return emit(const AuthenticationState.error());
    } catch (_) {
      return emit(const AuthenticationState.error());
    }
  }
}
