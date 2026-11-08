import 'package:flutter/material.dart';
import 'package:fa4_reverse_engineering/constants/app_sizes.dart';

class ChartBar extends StatelessWidget {
  const ChartBar({super.key, required this.fraction, required this.color});

  final double fraction;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final barColor = Theme.of(context).colorScheme.onSurface.withOpacity(0.85);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Column(
        children: [
          Expanded(
            child: FractionallySizedBox(
              heightFactor: fraction,
              alignment: Alignment.bottomCenter,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: barColor,
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(8)),
                ),
                child: const SizedBox(width: double.infinity),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Container(
            height: kColorBoxSize,
            width: double.infinity,
            color: color,
          ),
        ],
      ),
    );
  }
}
