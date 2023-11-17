import 'package:flutter/material.dart';
import 'package:practica3/models/transaction.dart';
import 'package:practica3/repositories/transaction_repository.dart';
import 'add_expense_screen.dart';
import 'add_income_screen.dart';
import 'package:practica3/transaction_utils.dart';

class BalanceScreen extends StatefulWidget {
  @override
  _BalanceScreenState createState() => _BalanceScreenState();
}

class _BalanceScreenState extends State<BalanceScreen> {
  TransactionRepository _transactionRepository = TransactionRepository();
  List<Transaction> _transactions = [];

  @override
  void initState() {
    super.initState();
    _loadTransactions();
  }

  _loadTransactions() async {
    List<Transaction> transactions = await _transactionRepository.getTransactions();
    setState(() {
      _transactions = transactions;
    });
  }

  double getBalance() {
    return TransactionUtils.getBalance(_transactions);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Saldo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Saldo Actual:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              '\$${getBalance().toStringAsFixed(2)}',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddIncomeScreen()),
                );
                _loadTransactions();
              },
              child: Text('Agregar Ingreso'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddExpenseScreen()),
                );
                _loadTransactions();
              },
              child: Text('Agregar Egreso'),
            ),
            SizedBox(height: 20),
            Text(
              'Historial de Transacciones:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _transactions.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_transactions[index].description),
                    subtitle: Text(
                      '${_transactions[index].type == 'income' ? 'Ingreso' : 'Egreso'} - \$${_transactions[index].amount}',
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

