import 'package:flutter/material.dart';
import 'package:fa4_reverse_engineering/constants/app_sizes.dart';
import 'package:fa4_reverse_engineering/models/parameter.dart';
import 'package:fa4_reverse_engineering/models/supply.dart';
import 'package:fa4_reverse_engineering/widgets/chart_bar.dart';

class SupplyChart extends StatelessWidget {
  const SupplyChart({
    super.key,
    required this.supplies,
    required this.parameters,
  });

  final List<Supply> supplies;
  final List<Parameter> parameters;

  double _totalFor(Parameter parameter) {
    double sum = 0;
    for (final supply in supplies) {
      if (supply.category == parameter) {
        sum += supply.total;
      }
    }
    return sum;
  }

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;

    final totals = [for (final p in parameters) _totalFor(p)];
    double maxTotal = 0;
    for (final t in totals) {
      if (t > maxTotal) maxTotal = t;
    }

    return Container(
      margin: const EdgeInsets.all(kScreenPadding),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      height: kChartHeight,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [primary.withOpacity(0.0), primary.withOpacity(0.2)],
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          for (int i = 0; i < parameters.length; i++)
            Expanded(
              child: ChartBar(
                fraction: maxTotal > 0
                    ? (totals[i] / maxTotal).clamp(0.0, 1.0).toDouble()
                    : 0,
                color: parameters[i].color,
              ),
            ),
        ],
      ),
    );
  }
}