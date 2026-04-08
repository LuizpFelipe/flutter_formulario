import 'package:flutter/material.dart';
import 'package:flutter_formulario/components/chart_bar.dart';
import 'package:flutter_formulario/models/transaction.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  const Chart(this.transaction, {super.key});

  final List<Transaction> transaction;

  List<Map<String, Object>> get groupedTransaction {
    return List.generate(7, (index) {
      final hoje = DateTime.now();
      final inicioSemana = hoje.subtract(Duration(days: hoje.weekday - 1));

      final weeDay = inicioSemana.add(Duration(days: index));

      double valorTotal = 0.0;

      for (var i = 0; i < transaction.length; i++) {
        bool mesmoDia = transaction[i].date.day == weeDay.day;
        bool mesmoMes = transaction[i].date.month == weeDay.month;
        bool mesmoAno = transaction[i].date.year == weeDay.year;

        if (mesmoDia && mesmoMes && mesmoAno) {
          valorTotal += transaction[i].value;
        }
      }

      return {'day': DateFormat.E().format(weeDay)[0], 'value': valorTotal};
    });
  }

  double get _weekTotalValue {
    return groupedTransaction.fold(0.0, (sum, tr) {
      return sum + (tr['value'] as double);
    });
  }

  @override
  Widget build(BuildContext context) {
    final total = _weekTotalValue;
    groupedTransaction;

    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransaction.map((tr) {
            return Expanded(
              child: Flexible(
                fit: FlexFit.tight,
                child: ChartBar(
                  tr['day'].toString(),
                  (tr['value'] as double),
                  total == 0 ? 0 : (tr['value'] as double) / total,
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
