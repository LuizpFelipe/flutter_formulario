import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl =
      'https://fastapiapp-production-64c0.up.railway.app';

  static Future<void> criarTransacao({
    required String titulo,
    required double valor,
    required DateTime data,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl/transacoes'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'titulo': titulo,
        'valor': valor,
        'data': data.toIso8601String(),
      }),
    );

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception('Erro ao criar transação');
    }
  }

  static Future<List<dynamic>> buscarTransacoes() async {
    final response = await http.get(Uri.parse('$baseUrl/transacoes'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Erro ao buscar transações');
    }
  }

  static Future<void> deletarTransacao(String id) async {
    final response = await http.delete(Uri.parse('$baseUrl/transacoes/$id'));

    if (response.statusCode != 200) {
      throw Exception('Erro ao deletar');
    }
  }

  static Future<void> atualizarTransacao({
    required String id,
    String? titulo,
    double? valor,
    DateTime? data,
  }) async {
    final Map<String, dynamic> body = {};

    if (titulo != null) body['titulo'] = titulo;
    if (valor != null) body['valor'] = valor;
    if (data != null) body['data'] = data.toIso8601String();

    final response = await http.patch(
      Uri.parse('$baseUrl/transacoes/$id'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(body),
    );

    if (response.statusCode != 200) {
      throw Exception('Erro ao atualizar transação');
    }
  }
}
