import 'data/data.dart';
import 'dto/transaction_input.dart';
import 'models/models.dart';

class PaymentRepository {
  PaymentRepository();

  Future<void> topUp(double amount) async {
    if (balance_data["totalBalance"] != null) {
      balance_data["totalBalance"] = amount + balance_data["totalBalance"]!;
    }
  }

  Future<double> getTotalBalance() async {
    if (balance_data["totalBalance"] != null) {
      return balance_data["totalBalance"]!;
    }
    return 0.0;
  }

  Future<void> makeTransaction(TransactionInput transactionInput) async {
    if (balance_data["totalBalance"] == null) {
      throw new Exception("Invalid Transaction!");
    }
    if (balance_data["totalBalance"]! <= transactionInput.amount) {
      throw new Exception("Insufficient Balance!");
    }
    balance_data["transactions"] = [
      ...balance_data["transactions"],
      transactionInput
    ];
  }

  Future<List<UpcomingPayment>> getUpcomingTransactions() async {
    await Future.delayed(const Duration(seconds: 2));
    if (balance_data["upcoming"] == null) {
      throw new Exception("Something went wrong!");
    }
    return (balance_data['upcoming'] as List)
        .map((data) => UpcomingPayment.fromJson(data)).toList();
  }
}
