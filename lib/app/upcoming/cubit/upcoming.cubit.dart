import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kacha_app/utils/error_string.dart';
import 'package:payment_repository/payment_repository.dart';

part 'upcoming.state.dart';

class UpcomingCubit extends Cubit<UpcomingState> {
  final PaymentRepository paymentRepository;

  UpcomingCubit({required this.paymentRepository}) : super(UpcomingUnknown());

  void loadUpcomingCard() async {
    emit(UpcomingLoading());
    try {
      final List<UpcomingPayment> item = await paymentRepository.getUpcomingTransactions();
      emit(UpcomingLoadSuccess(item));
    } catch (e) {
      emit(UpcomingOperationFailure(errorString(e)));
      emit(UpcomingUnknown());
    }
  }
}
