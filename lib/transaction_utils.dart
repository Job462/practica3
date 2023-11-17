import 'package:practica3/models/transaction.dart';

class TransactionUtils {
  static double getBalance(List<Transaction> transactions) {
    double income = 0;
    double expense = 0;

    for (var transaction in transactions) {
      if (transaction.type == 'income') {
        income += transaction.amount;
      } else {
        expense += transaction.amount;
      }
    }

    return income - expense;
  }
}