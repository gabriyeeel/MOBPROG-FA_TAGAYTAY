import 'package:flutter/material.dart';

import 'constants.dart';

class CustomText extends StatelessWidget {
  final String text;
  final double size;
  final FontWeight weight;
  final Color color;
  final bool italic;

  const CustomText({
    super.key,
    required this.text,
    required this.size,
    required this.color,
    this.weight = FontWeight.normal,
    this.italic = false,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: size,
        fontWeight: weight,
        color: AppColors.cream,
        fontStyle: italic ? FontStyle.italic : FontStyle.normal,
      ),
    );
  }
}
