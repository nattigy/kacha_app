import 'data/data.dart';
import 'models/models.dart';

class PaymentRepository {
  PaymentRepository();

  Future<void> topUp(double amount) async {
    await Future.delayed(const Duration(seconds: 2));
    if (balance_data["totalBalance"] != null) {
      balance_data["totalBalance"] = amount + balance_data["totalBalance"]!;
      balance_data["transactions"] = [
        ...balance_data["transactions"],
        {
          "amount": amount,
          "type": TransactionType.credit,
          "to": "self",
          "description": "deposit",
          "createdAt": DateTime.now(),
        }
      ];
    }
  }

  Future<double> getTotalBalance() async {
    await Future.delayed(const Duration(seconds: 1));
    if (balance_data["totalBalance"] != null) {
      return balance_data["totalBalance"]!;
    }
    return 0.0;
  }

  Future<void> makeTransaction(Transaction transaction) async {
    await Future.delayed(const Duration(seconds: 1));
    if (balance_data["totalBalance"] == null) {
      throw new Exception("Invalid Transaction!");
    }
    if (balance_data["totalBalance"]! <= transaction.amount) {
      throw new Exception("Insufficient Balance!");
    }
    if(transaction.isUpcoming == true){
      balance_data["upcoming"] = (balance_data["upcoming"] as List)
          .map((u) {
         if (u["id"] == transaction.upComingId){
           u["isPaid"] = true;
         }
         return u;
      }).toList();
    }
    balance_data["totalBalance"] =
        balance_data["totalBalance"] - transaction.amount;
    balance_data["transactions"] = [
      ...balance_data["transactions"],
      {
        "amount": transaction.amount,
        "to": transaction.to,
        "description": transaction.description,
        "createdAt": transaction.createdAt,
        "type": transaction.type,
      }
    ];
  }

  Future<List<UpcomingPayment>> getUpcomingTransactions() async {
    await Future.delayed(const Duration(seconds: 2));
    if (balance_data["upcoming"] == null) {
      throw new Exception("Something went wrong!");
    }
    return (balance_data['upcoming'] as List)
        .map((data) => UpcomingPayment.fromJson(data))
        .toList();
  }

  Future<List<Transaction>> getTransactions() async {
    await Future.delayed(const Duration(seconds: 2));
    if (balance_data["transactions"] == null) {
      throw new Exception("Something went wrong!");
    }
    return (balance_data['transactions'] as List)
        .map((data) => Transaction.fromJson(data))
        .toList();
  }
}
