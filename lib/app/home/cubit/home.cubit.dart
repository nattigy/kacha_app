import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kacha_app/utils/error_string.dart';
import 'package:payment_repository/payment_repository.dart';

part 'home.state.dart';

class HomeCubit extends Cubit<HomeState> {
  final PaymentRepository paymentRepository;

  HomeCubit({required this.paymentRepository}) : super(HomeUnknown());

  void loadHomeCard() async {
    emit(HomeLoading());
    try {
      final item = await paymentRepository.getTotalBalance();
      emit(HomeLoadSuccess(item));
    } catch (e) {
      emit(HomeOperationFailure(errorString(e)));
    }
  }
}
