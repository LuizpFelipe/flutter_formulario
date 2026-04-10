import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/transacao_provider.dart';
import 'chart_bar.dart';

class Chart extends StatelessWidget {
  const Chart({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<TransacaoProvider>();

    return Card(
      elevation: 6,
      margin: const EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: provider.recentesAgrupadas.map((data) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                data['day'] as String,
                data['value'] as double,
                provider.gastoTotalSemana == 0
                    ? 0
                    : (data['value'] as double) / provider.gastoTotalSemana,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
