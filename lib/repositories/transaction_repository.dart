import 'package:sqflite/sqflite.dart';
import 'package:practica3/helpers/database_helper.dart'; 
import 'package:practica3/models/transaction.dart' as LocalTransaction;


class TransactionRepository {
  DatabaseHelper _databaseHelper = DatabaseHelper();

  Future<int> insertTransaction(LocalTransaction.Transaction transaction) async {
    Database db = await _databaseHelper.database;
    return await db.insert('transactions', transaction.toMap());
  }

  Future<List<LocalTransaction.Transaction>> getTransactions() async {
    Database db = await _databaseHelper.database;
    List<Map<String, dynamic>> maps = await db.query('transactions');
    return List.generate(maps.length, (i) {
      return LocalTransaction.Transaction.fromMap(maps[i]);
    });
  }
}
