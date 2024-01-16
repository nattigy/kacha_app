part of 'users.bloc.dart';

class UsersState extends Equatable {
  const UsersState();

  @override
  List<Object?> get props => [];
}

class UserLoading extends UsersState {}

class UserUnknown extends UsersState {}

class DeleteUserSuccess extends UsersState {}

class UserLoadSuccess extends UsersState {
  final UserEntity user;

  const UserLoadSuccess(this.user);

  @override
  List<Object?> get props => [user];
}

class UserOperationFailure extends UsersState {
  final String message;

  const UserOperationFailure(this.message);
}
