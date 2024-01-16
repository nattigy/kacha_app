import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utils/error_string.dart';
import '../../auth/data/auth_repository.dart';
import '../data/user.repository.dart';
import '../entity/user.entity.dart';

part 'users.state.dart';

class UsersBloc extends Cubit<UsersState> {
  final AuthenticationRepository authenticationRepository;
  final UserRepository userRepository;

  UsersBloc({
    required this.authenticationRepository,
    required this.userRepository,
  }) : super(UserUnknown());

  void loadUser() async {
    emit(UserLoading());
    try {
      final item = await authenticationRepository.getUser();
      emit(UserLoadSuccess(item!));
    } catch (e) {
      emit(UserOperationFailure(errorString(e)));
    }
  }

  void deleteUser() async {
    emit(UserLoading());
    try {
      await userRepository.deleteUser();
      emit(DeleteUserSuccess());
    } catch (e) {
      emit(UserOperationFailure(errorString(e)));
      emit(UserUnknown());
    }
  }
}
