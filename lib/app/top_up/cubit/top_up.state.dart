part of 'top_up.cubit.dart';

class TopUpState extends Equatable {
  const TopUpState();

  @override
  List<Object?> get props => [];
}

class TopUpLoading extends TopUpState {}

class TopUpUnknown extends TopUpState {}

class TopUpLoadSuccess extends TopUpState {}

class TopUpOperationFailure extends TopUpState {
  final String message;

  const TopUpOperationFailure(this.message);
}
