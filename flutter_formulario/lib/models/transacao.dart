class Transacao {
  final String? id;
  final String titulo;
  final double valor;
  final DateTime data;

  Transacao({
    this.id,
    required this.titulo,
    required this.valor,
    required this.data,
  });

  factory Transacao.fromJson(Map<String, dynamic> json) {
    return Transacao(
      id: json['id']?.toString(),
      titulo: json['titulo'],
      valor: (json['valor'] as num).toDouble(),
      data: DateTime.parse(json['data']),
    );
  }

  Map<String, dynamic> toJson() {
    return {'titulo': titulo, 'valor': valor, 'data': data.toIso8601String()};
  }
}
