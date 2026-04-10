import 'package:flutter/material.dart';
import 'package:flutter_formulario/models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  TransactionList(this._transaction, this.onRemove, this.onEdit, {super.key});

  final List<Transaction> _transaction;
  final void Function(String) onRemove;
  final void Function(Transaction) onEdit;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 505,
      child: _transaction.isEmpty
          ? Column(
              children: [
                SizedBox(height: 20),
                Text("Nenhuma Trasação Cadastrada!"),
                SizedBox(height: 20),
                SizedBox(
                  height: 200,
                  child: Image.asset(
                    'assets/imagens/waiting.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            )
          : ListView.builder(
              itemCount: _transaction.length,
              itemBuilder: (ctx, index) {
                final tra = _transaction[index];
                return Card(
                  elevation: 5,
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      child: Padding(
                        padding: const EdgeInsets.all(6),
                        child: FittedBox(child: Text('R\$ ${tra.value}')),
                      ),
                    ),
                    title: Text(
                      tra.title,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(DateFormat('d MMM y').format(tra.date)),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () => onEdit(tra),
                          icon: Icon(Icons.edit),
                          color: Colors.blue,
                        ),
                        IconButton(
                          onPressed: () => onRemove(tra.id),
                          icon: Icon(Icons.delete),
                          color: Colors.red,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
