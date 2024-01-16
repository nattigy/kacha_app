import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NavigationBloc extends Cubit<NavigationState> {
  NavigationBloc() : super(NavigationUnknown());

  void navigateToHome(String pathName) {
    emit(NavigatedToHome(pathName));
  }

  void navigateToJobs({required String pathName}) {
    emit(NavigatedToJobs(pathName: pathName));
    emit(NavigationUnknown());
  }

  void navigateToPayments(String pathName) {
    emit(NavigatedToPayments(pathName));
    emit(NavigationUnknown());
  }

  void navigateToProfile(String pathName) {
    emit(NavigatedToProfile(pathName));
    emit(NavigationUnknown());
  }
}

abstract class NavigationState extends Equatable {
  @override
  List<Object> get props => [];
}

class NavigatedToHome extends NavigationState {
  final String pathName;

  NavigatedToHome(this.pathName);
}

class NavigatedToJobs extends NavigationState {
  final String pathName;

  NavigatedToJobs({required this.pathName});
}

class NavigatedToPayments extends NavigationState {
  final String pathName;

  NavigatedToPayments(this.pathName);
}

class NavigatedToProfile extends NavigationState {
  final String pathName;

  NavigatedToProfile(this.pathName);
}

class NavigationUnknown extends NavigationState {}
