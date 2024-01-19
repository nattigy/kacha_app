part of 'home.cubit.dart';

class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object?> get props => [];
}

class HomeLoading extends HomeState {}

class HomeUnknown extends HomeState {}

class HomeLoadSuccess extends HomeState {
  final double totalBalance;

  const HomeLoadSuccess(this.totalBalance);

  @override
  List<Object?> get props => [totalBalance];
}

class HomeOperationFailure extends HomeState {
  final String message;

  const HomeOperationFailure(this.message);
}
