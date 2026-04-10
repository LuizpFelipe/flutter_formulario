import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../providers/transacao_provider.dart';
import '../../models/transacao.dart';

class TransactionForm extends StatefulWidget {
  final Transacao? transacaoParaEditar; // Recebe os dados se for edição

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
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              TextField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Título'),
              ),
              TextField(
                controller: _valueController,
                decoration: const InputDecoration(labelText: 'Valor (R\$)'),
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
              ),
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
                      if (pickedDate != null)
                        setState(() => _selectedDate = pickedDate);
                    },
                    child: const Text(
                      'Selecionar Data',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text(
                  widget.transacaoParaEditar == null
                      ? 'Nova Transação'
                      : 'Salvar Alterações',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
