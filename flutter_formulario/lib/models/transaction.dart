class Transaction {
  final String id;
  final String title;
  final double value;
  final DateTime date;

  Transaction(this.id, this.title, this.value, this.date);

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      json['id'].toString(),
      json['titulo'],
      json['valor'],
      DateTime.parse(json['data']),
    );
  }
}
