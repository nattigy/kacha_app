import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kacha_app/utils/error_string.dart';
import 'package:payment_repository/payment_repository.dart';

part 'top_up.state.dart';

class TopUpCubit extends Cubit<TopUpState> {
  final PaymentRepository paymentRepository;

  TopUpCubit({required this.paymentRepository}) : super(TopUpUnknown());

  void topUp(String amount) async {
    emit(TopUpLoading());
    try {
      var number = 0.0;
      try{
        number = double.parse(amount);
      } catch (e){
        throw Exception("Invalid input");
      }
      await paymentRepository.topUp(number);
      emit(TopUpLoadSuccess());
      emit(TopUpUnknown());
    } catch (e) {
      emit(TopUpOperationFailure(errorString(e)));
      emit(TopUpUnknown());
    }
  }
}
