part of 'send.cubit.dart';

class SendState extends Equatable {
  const SendState();

  @override
  List<Object?> get props => [];
}

class SendLoading extends SendState {}

class SendAllValid extends SendState {
  final Transaction transaction;

  const SendAllValid(this.transaction);

  @override
  List<Object?> get props => [transaction];
}

class SendUnknown extends SendState {}

class SendLoadSuccess extends SendState {}

class SendOperationFailure extends SendState {
  final String message;

  const SendOperationFailure(this.message);

  @override
  List<Object?> get props => [message];
}
