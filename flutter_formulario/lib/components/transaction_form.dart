import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class TransactionForm extends StatefulWidget {
  const TransactionForm(this.onSubmit, {this.transaction, super.key});

  final Function(String? id, String title, double value, DateTime date)
  onSubmit;
  final Transaction? transaction;

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final _titleController = TextEditingController();
  final _valueController = TextEditingController();
  DateTime? _selectDate = DateTime.now();

  @override
  void initState() {
    super.initState();

    // 🔥 Se veio uma transação → modo edição
    if (widget.transaction != null) {
      _titleController.text = widget.transaction!.title;
      _valueController.text = widget.transaction!.value.toString();
      _selectDate = widget.transaction!.date;
    }
  }

  void _submitForm() {
    String text = _valueController.text.replaceAll(',', '.');
    final value = double.tryParse(text);

    widget.onSubmit(
      widget.transaction?.id, // se for null → cria | se tiver → edita
      _titleController.text,
      value ?? 0,
      _selectDate!,
    );

    _valueController.text = '';
    _titleController.text = '';
  }

  _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: _selectDate ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    ).then((picketDate) {
      if (picketDate == null) return;

      setState(() {
        _selectDate = picketDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: "Título"),
            ),
            TextField(
              controller: _valueController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[\d.,]')),
              ],
              decoration: InputDecoration(labelText: 'Valor (R\$)'),
            ),
            SizedBox(
              height: 70,
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      _selectDate == null
                          ? "Nenhuma Data Selecionada!"
                          : 'Data Selecionada: ${DateFormat('d/M/y').format(_selectDate!)}',
                    ),
                  ),
                  TextButton(
                    onPressed: _showDatePicker,
                    style: TextButton.styleFrom(foregroundColor: Colors.purple),
                    child: Text(
                      'Selecionar Data',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: _submitForm,
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.purple,
                    foregroundColor: Colors.white,
                  ),
                  child: Text(
                    widget.transaction != null ? 'Atualizar' : 'Salvar',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
