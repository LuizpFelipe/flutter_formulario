import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transacao.dart';
import '../services/transacao_service.dart';

class TransacaoProvider with ChangeNotifier {
  final TransacaoService _service = TransacaoService();
  List<Transacao> _transacoes = [];
  bool _isLoading = false;

  List<Transacao> get transacoes => _transacoes;
  bool get isLoading => _isLoading;

  List<Map<String, Object>> get recentesAgrupadas {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      double totalSum = 0.0;

      for (var i = 0; i < _transacoes.length; i++) {
        bool mesmaData =
            _transacoes[i].data.day == weekDay.day &&
            _transacoes[i].data.month == weekDay.month &&
            _transacoes[i].data.year == weekDay.year;

        if (mesmaData) {
          totalSum += _transacoes[i].valor;
        }
      }
      return {'day': DateFormat.E().format(weekDay)[0], 'value': totalSum};
    }).reversed.toList();
  }

  double get gastoTotalSemana {
    return recentesAgrupadas.fold(
      0.0,
      (sum, item) => sum + (item['value'] as double),
    );
  }

  Future<void> atualizarTransacoes() async {
    _isLoading = true;
    notifyListeners();
    try {
      _transacoes = await _service.fetchAll();
    } catch (e) {
      debugPrint("Erro ao buscar: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> adicionarTransacao(
    String titulo,
    double valor,
    DateTime data,
  ) async {
    await _service.create(Transacao(titulo: titulo, valor: valor, data: data));
    await atualizarTransacoes();
  }

  Future<void> editarTransacao(
    String id,
    String titulo,
    double valor,
    DateTime data,
  ) async {
    await _service.update(
      Transacao(id: id, titulo: titulo, valor: valor, data: data),
    );
    await atualizarTransacoes();
  }

  Future<void> removerTransacao(String id) async {
    await _service.delete(id);
    await atualizarTransacoes();
  }
}
