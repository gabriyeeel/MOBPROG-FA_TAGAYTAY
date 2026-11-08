import 'package:flutter/material.dart';
import 'package:fa4_reverse_engineering/constants/app_colors.dart';

enum SupplyCategory {
  melee('Melee', kMeleeColor),
  assaultRifle('Assault Rifle', kAssaultRifleColor);

  const SupplyCategory(this.label, this.color);

  final String label;
  final Color color;
}
