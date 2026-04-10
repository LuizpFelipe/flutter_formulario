import 'package:flutter/material.dart';
import 'package:flutter_formulario/components/chart.dart';
import 'package:flutter_formulario/components/transaction_form.dart';
import 'package:flutter_formulario/components/transaction_list.dart';
import 'package:flutter_formulario/services/api_service.dart';
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
  final List<Transaction> _transaction = [];

  Future<void> carregarTransacoes() async {
    final data = await ApiService.buscarTransacoes();

    setState(() {
      _transaction.clear();

      for (var item in data) {
        _transaction.add(
          Transaction(
            item['id'].toString(),
            item['titulo'],
            (item['valor'] as num).toDouble(),
            DateTime.parse(item['data']),
          ),
        );
      }
    });
  }

  @override
  void initState() {
    super.initState();
    carregarTransacoes();
  }

  List<Transaction> get _recentransactio {
    return _transaction.where((tr) {
      return tr.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  void _saveTransaction(
    String? id,
    String title,
    double value,
    DateTime date,
  ) async {
    if (title.isEmpty || value <= 0) return;

    try {
      if (id == null) {
        await ApiService.criarTransacao(
          titulo: title,
          valor: value,
          data: date,
        );
      } else {
        await ApiService.atualizarTransacao(
          id: id,
          titulo: title,
          valor: value,
          data: date,
        );
      }

      await carregarTransacoes();
      Navigator.of(context).pop();
    } catch (e) {
      print("Erro ao salvar: $e");
    }
  }

  void _deleteTransaction(String id) async {
    try {
      await ApiService.deletarTransacao(id);
      await carregarTransacoes();
    } catch (e) {
      print("Erro ao deletar: $e");
    }
  }

  // 🔥 AGORA ACEITA TRANSACTION (EDIT)
  void _openTransactionFormModel(
    BuildContext context, [
    Transaction? transaction,
  ]) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return TransactionForm(_saveTransaction, transaction: transaction);
      },
    );
  }

  // 🔥 FUNÇÃO DE EDITAR
  void _editTransaction(Transaction transaction) {
    _openTransactionFormModel(context, transaction);
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
            TransactionList(
              _transaction,
              _deleteTransaction,
              _editTransaction, // 🔥 NOVO
            ),
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
