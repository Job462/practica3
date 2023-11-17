import 'package:flutter/material.dart';
import 'package:practica3/models/transaction.dart' as LocalTransaction;
import 'package:practica3/repositories/transaction_repository.dart';
import 'package:practica3/transaction_utils.dart';

class AddExpenseScreen extends StatefulWidget {
  @override
  _AddExpenseScreenState createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {
  TransactionRepository _transactionRepository = TransactionRepository();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _amountController = TextEditingController();
  List<LocalTransaction.Transaction> _transactions = [];
  bool showError = false;

  @override
  void initState() {
    super.initState();
    _loadTransactions();
  }

  _loadTransactions() async {
    List<LocalTransaction.Transaction> transactions =
        await _transactionRepository.getTransactions();
    setState(() {
      _transactions = transactions;
    });
  }

  double getBalance() {
    return TransactionUtils.getBalance(_transactions);
  }

  _addExpense() async {
    String description = _descriptionController.text;
    double amount = double.tryParse(_amountController.text) ?? 0;

    if (amount <= 0) {
      return;
    }

    if (amount > getBalance()) {
      setState(() {
        showError = true;
      });
      return;
    }

    LocalTransaction.Transaction transaction = LocalTransaction.Transaction(
      description: description,
      amount: amount,
      type: 'expense',
    );

    await _transactionRepository.insertTransaction(transaction);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Agregar Egreso'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: 'Descripción'),
            ),
            TextField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Monto'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _addExpense,
              child: Text('Agregar Egreso'),
            ),
            SizedBox(height: 8),
            Visibility(
              visible: showError,
              child: Text(
                'Saldo insuficiente',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
