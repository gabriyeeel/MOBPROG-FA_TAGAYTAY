import 'package:flutter/material.dart';
import 'package:fa4_reverse_engineering/constants/app_sizes.dart';
import 'package:fa4_reverse_engineering/models/supply.dart';
import 'package:fa4_reverse_engineering/utils/formatters.dart';
import 'package:fa4_reverse_engineering/widgets/category_tag.dart';

class SupplyItem extends StatelessWidget {
  const SupplyItem({super.key, required this.supply});

  final Supply supply;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: kScreenPadding, vertical: 5),
      color: Theme.of(context).colorScheme.surface,
      surfaceTintColor: Colors.transparent,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(kCardRadius),
      ),
      child: Padding(
        padding: const EdgeInsets.all(kScreenPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(supply.name, style: textTheme.titleLarge),
            const SizedBox(height: 4),
            Row(
              children: [
                Expanded(
                  child: Text(
                    '${formatAmount(supply.unitPrice)} X ${supply.quantity} = ${formatAmount(supply.total)}',
                    style: textTheme.bodyMedium,
                  ),
                ),
                CategoryTag(category: supply.category),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
