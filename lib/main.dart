import 'package:flutter/material.dart';
import 'package:practica3/screen/balance_screen.dart';
import 'package:practica3/screen/add_income_screen.dart';
import 'package:practica3/screen/add_expense_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Practica3',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: BalanceScreen(),
      routes: {
        '/addIncome': (context) => AddIncomeScreen(),
        '/addExpense': (context) => AddExpenseScreen(),
      },
    );
  }
}
