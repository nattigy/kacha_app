import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kacha_app/utils/error_string.dart';
import 'package:payment_repository/payment_repository.dart';

part 'history.state.dart';

class HistoryCubit extends Cubit<HistoryState> {
  final PaymentRepository paymentRepository;

  HistoryCubit({required this.paymentRepository}) : super(HistoryUnknown());

  void loadHistoryCard() async {
    emit(HistoryLoading());
    try {
      final List<Transaction> item = await paymentRepository.getTransactions();
      emit(HistoryLoadSuccess(item));
    } catch (e) {
      emit(HistoryOperationFailure(errorString(e)));
      emit(HistoryUnknown());
    }
  }
}
