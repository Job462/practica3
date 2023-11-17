// add_income_screen.dart
import 'package:flutter/material.dart';
import 'package:practica3/models/transaction.dart' as LocalTransaction;
import 'package:practica3/repositories/transaction_repository.dart';

class AddIncomeScreen extends StatefulWidget {
  @override
  _AddIncomeScreenState createState() => _AddIncomeScreenState();
}

class _AddIncomeScreenState extends State<AddIncomeScreen> {
  TransactionRepository _transactionRepository = TransactionRepository();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _amountController = TextEditingController();

  _addIncome() async {
    String description = _descriptionController.text;
    double amount = double.tryParse(_amountController.text) ?? 0;

    if (amount <= 0) {
      return;
    }

    LocalTransaction.Transaction transaction = LocalTransaction.Transaction(
      description: description,
      amount: amount,
      type: 'income',
    );

    await _transactionRepository.insertTransaction(transaction);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Agregar Ingreso'),
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
              onPressed: _addIncome,
              child: Text('Agregar Ingreso'),
            ),
          ],
        ),
      ),
    );
  }
}
