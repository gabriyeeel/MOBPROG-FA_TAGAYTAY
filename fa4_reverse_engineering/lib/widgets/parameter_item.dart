import 'package:flutter/material.dart';
import 'package:fa4_reverse_engineering/constants/app_sizes.dart';
import 'package:fa4_reverse_engineering/models/parameter.dart';

class ParameterItem extends StatelessWidget {
  const ParameterItem({super.key, required this.parameter});

  final Parameter parameter;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return ListTile(
      leading: Container(
        width: kColorBoxSize,
        height: kColorBoxSize,
        color: parameter.color,
      ),
      title: Text(parameter.name, style: textTheme.bodyLarge),
      trailing: Text(
        parameter.className,
        style: textTheme.bodySmall?.copyWith(fontSize: 10),
      ),
    );
  }
}