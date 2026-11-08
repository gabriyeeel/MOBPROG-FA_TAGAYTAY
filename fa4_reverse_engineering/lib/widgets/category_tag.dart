import 'package:flutter/material.dart';
import 'package:fa4_reverse_engineering/constants/app_sizes.dart';
import 'package:fa4_reverse_engineering/models/parameter.dart';

class CategoryTag extends StatelessWidget {
  const CategoryTag({super.key, required this.category, this.uppercase = false});

  final Parameter category;
  final bool uppercase;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: kColorBoxSize,
          height: kColorBoxSize,
          color: category.color,
        ),
        const SizedBox(width: 8),
        Text(
          uppercase ? category.name.toUpperCase() : category.name,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }
}