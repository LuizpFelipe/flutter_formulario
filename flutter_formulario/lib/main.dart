import 'dart:math' show Random;

import 'package:flutter/material.dart';
import 'package:flutter_formulario/components/chart.dart';
import 'package:flutter_formulario/components/transaction_form.dart';
import 'package:flutter_formulario/components/transaction_list.dart';
import 'models/transaction.dart';

void main() => runApp(ExpensesApp());

class ExpensesApp extends StatelessWidget {
  const ExpensesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const MyHomePage(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: false,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.purple,
          foregroundColor: Colors.white,
        ),
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.amber,
          primary: Colors.purple,
          secondary: Colors.amber,
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final titleController = TextEditingController();
  final valueController = TextEditingController();

  final List<Transaction> _transaction = [
    Transaction(
      't2',
      'Carro',
      299.99,
      DateTime.now().subtract(Duration(days: -2)),
    ),
    Transaction(
      't3',
      'Casa',
      600.99,
      DateTime.now().subtract(Duration(days: -3)),
    ),
    Transaction(
      't1',
      'Mercado',
      400.99,
      DateTime.now().subtract(Duration(days: -1)),
    ),
    Transaction(
      't4',
      'Academia',
      150.99,
      DateTime.now().subtract(Duration(days: -4)),
    ),
    Transaction(
      'Gasolina',
      'Carro',
      299.99,
      DateTime.now().subtract(Duration(days: -5)),
    ),
    Transaction(
      't6',
      'Viagem',
      900.00,
      DateTime.now().subtract(Duration(days: -6)),
    ),
  ];

  List<Transaction> get _recentransactio {
    return _transaction.where((tr) {
      return tr.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  void _addTransaction(String title, double value, DateTime date) {
    final newTransaction = Transaction(
      Random().nextDouble().toString(),
      title,
      value,
      date,
    );

    if (title.isEmpty || value <= 0 || date == null) {
      return;
    }

    setState(() {
      _transaction.add(newTransaction);
    });

    Navigator.of(context).pop();
  }

  _deleteTransaction(String id) {
    setState(() {
      _transaction.removeWhere((tr) {
        return tr.id == id;
      });
    });
  }

  void _openTransactionFormModel(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return TransactionForm(_addTransaction);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Despesas Pessoais"),
        actions: [
          IconButton(
            onPressed: () => _openTransactionFormModel(context),
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Chart(_recentransactio),
            TransactionList(_transaction, _deleteTransaction),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _openTransactionFormModel(context),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
