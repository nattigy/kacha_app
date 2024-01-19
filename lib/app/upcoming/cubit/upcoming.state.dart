part of 'upcoming.cubit.dart';

class UpcomingState extends Equatable {
  const UpcomingState();

  @override
  List<Object?> get props => [];
}

class UpcomingLoading extends UpcomingState {}

class UpcomingUnknown extends UpcomingState {}

class UpcomingLoadSuccess extends UpcomingState {
  final List<UpcomingPayment> upcomingPayments;

  const UpcomingLoadSuccess(this.upcomingPayments);

  @override
  List<Object?> get props => [upcomingPayments];
}

class UpcomingOperationFailure extends UpcomingState {
  final String message;

  const UpcomingOperationFailure(this.message);
}
