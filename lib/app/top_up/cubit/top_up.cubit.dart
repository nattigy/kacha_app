import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kacha_app/utils/error_string.dart';
import 'package:payment_repository/payment_repository.dart';

part 'top_up.state.dart';

class TopUpCubit extends Cubit<TopUpState> {
  final PaymentRepository paymentRepository;

  TopUpCubit({required this.paymentRepository}) : super(TopUpUnknown());

  void topUp(double amount) async {
    emit(TopUpLoading());
    try {
       await paymentRepository.topUp(amount);
      emit(TopUpLoadSuccess());
    } catch (e) {
      emit(TopUpOperationFailure(errorString(e)));
    }
  }
}
