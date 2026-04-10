import 'package:dio/dio.dart';
import '../models/transacao.dart';

class TransacaoService {
  final _dio = Dio(
    BaseOptions(baseUrl: 'https://fastapiapp-production-64c0.up.railway.app'),
  );

  Future<List<Transacao>> fetchAll() async {
    final response = await _dio.get('/transacoes');
    final lista = response.data as List;
    return lista.map((json) => Transacao.fromJson(json)).toList();
  }

  Future<void> create(Transacao t) async {
    await _dio.post('/transacoes', data: t.toJson());
  }

  Future<void> update(Transacao t) async {
    await _dio.patch('/transacoes/${t.id}', data: t.toJson());
  }

  Future<void> delete(String id) async {
    await _dio.delete('/transacoes/$id');
  }
}
