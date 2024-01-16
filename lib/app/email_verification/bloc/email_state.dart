part of 'email_cubit.dart';

abstract class EmailState extends Equatable {
  const EmailState();

  @override
  List<Object> get props => [];
}

class EmailLoading extends EmailState {}

class EmailVerifying extends EmailState {}

class EmailAuthCodeSent extends EmailState {
  final String token;

  const EmailAuthCodeSent(this.token);

  @override
  List<Object> get props => [token];
}

class EmailAuthCodeAutoRetrievalTimeout extends EmailState {}

class EmailSuccessful extends EmailState {}

class EmailNotVerified extends EmailState {}

class EmailVerificationFailure extends EmailState {
  final String message;

  const EmailVerificationFailure(this.message);

  @override
  List<Object> get props => [message];
}

class EmailUnknown extends EmailState {}
