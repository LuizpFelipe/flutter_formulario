import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../providers/transacao_provider.dart';
import '../../models/transacao.dart';

class TransactionForm extends StatefulWidget {
  final Transacao? transacaoParaEditar;

  const TransactionForm({super.key, this.transacaoParaEditar});

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final _titleController = TextEditingController();
  final _valueController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    if (widget.transacaoParaEditar != null) {
      _titleController.text = widget.transacaoParaEditar!.titulo;
      _valueController.text = widget.transacaoParaEditar!.valor.toString();
      _selectedDate = widget.transacaoParaEditar!.data;
    }
  }

  void _submitForm() {
    final title = _titleController.text;
    final value = double.tryParse(_valueController.text) ?? 0.0;

    if (title.isEmpty || value <= 0) return;

    final provider = context.read<TransacaoProvider>();

    if (widget.transacaoParaEditar == null) {
      provider.adicionarTransacao(title, value, _selectedDate);
    } else {
      provider.editarTransacao(
        widget.transacaoParaEditar!.id!,
        title,
        value,
        _selectedDate,
      );
    }

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(
          top: 10,
          left: 10,
          right: 10,
          bottom: keyboardSpace + 20,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Título'),
              autofocus: true,
            ),
            TextField(
              controller: _valueController,
              decoration: const InputDecoration(labelText: 'Valor (R\$)'),
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              onSubmitted: (_) => _submitForm(),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Data: ${DateFormat('dd/MM/y').format(_selectedDate)}',
                  ),
                ),
                TextButton(
                  onPressed: () async {
                    final pickedDate = await showDatePicker(
                      context: context,
                      initialDate: _selectedDate,
                      firstDate: DateTime(2020),
                      lastDate: DateTime.now(),
                    );
                    if (pickedDate != null) {
                      setState(() => _selectedDate = pickedDate);
                    }
                  },
                  child: const Text(
                    'Selecionar Data',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            ElevatedButton(
              onPressed: _submitForm,
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
                foregroundColor: Colors.white,
              ),
              child: Text(
                widget.transacaoParaEditar == null
                    ? 'Nova Transação'
                    : 'Salvar Alterações',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
