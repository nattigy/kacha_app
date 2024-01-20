import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kacha_app/utils/error_string.dart';
import 'package:payment_repository/payment_repository.dart';

part 'send.state.dart';

class SendCubit extends Cubit<SendState> {
  final PaymentRepository paymentRepository;

  SendCubit({required this.paymentRepository}) : super(SendUnknown());

  void send(Transaction transaction) async {
    emit(SendLoading());
    try {
      await paymentRepository.makeTransaction(transaction);
      emit(SendLoadSuccess());
      emit(SendUnknown());
    } catch (e) {
      emit(SendOperationFailure(errorString(e)));
      emit(SendUnknown());
    }
  }

  void checkValid(String amount, String to, String description) async {
    try {
      final number = double.parse(amount);
      if (to.length < 3) {
        emit(SendOperationFailure("Phone number should be greater than 3!"));
        emit(SendUnknown());
      } else if (description.length < 3) {
        emit(SendOperationFailure(
            "Description length should be greater than 3!"));
        emit(SendUnknown());
      } else {
        emit(SendAllValid(Transaction(
          amount: number,
          type: TransactionType.debit,
          to: to,
          description: description,
          createdAt: DateTime.now(),
        )));
      }
    } catch (e) {
      emit(SendOperationFailure("Invalid input"));
      emit(SendUnknown());
    }
  }
}
