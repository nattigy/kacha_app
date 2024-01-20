part of 'history.cubit.dart';

class HistoryState extends Equatable {
  const HistoryState();

  @override
  List<Object?> get props => [];
}

class HistoryLoading extends HistoryState {}

class HistoryUnknown extends HistoryState {}

class HistoryLoadSuccess extends HistoryState {
  final List<Transaction> transactionHistory;

  const HistoryLoadSuccess(this.transactionHistory);

  @override
  List<Object?> get props => [transactionHistory];
}

class HistoryOperationFailure extends HistoryState {
  final String message;

  const HistoryOperationFailure(this.message);
}
