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

      return {
        'day': DateFormat.E().format(weekDay)[0], // Ex: 'S', 'T', 'Q'
        'value': totalSum,
      };
    }).reversed.toList(); // Inverte para o dia atual ficar na direita
  }

  // Calcula o valor total gasto na semana para definir a altura das barras
  double get gastoTotalSemana {
    return recentesAgrupadas.fold(0.0, (sum, item) {
      return sum + (item['value'] as double);
    });
  }

  // Função para buscar dados da API
  Future<void> atualizarTransacoes() async {
    _isLoading = true;
    notifyListeners(); // Avisa a UI para mostrar o carregando (spinner)

    try {
      _transacoes = await _service.fetchAll();
    } catch (e) {
      print("Erro ao buscar: $e");
    } finally {
      _isLoading = false;
      notifyListeners(); // Avisa a UI que os dados chegaram
    }
  }

  // Função para Adicionar
  Future<void> adicionarTransacao(
    String titulo,
    double valor,
    DateTime data,
  ) async {
    final nova = Transacao(titulo: titulo, valor: valor, data: data);
    await _service.create(nova);
    await atualizarTransacoes(); // Recarrega a lista após salvar
  }

  // Função para Deletar
  Future<void> removerTransacao(String id) async {
    await _service.delete(id);
    await atualizarTransacoes(); // Recarrega a lista após deletar
  }
}
