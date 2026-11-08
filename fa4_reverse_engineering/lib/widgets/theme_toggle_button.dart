import 'package:flutter/material.dart';
import 'package:fa4_reverse_engineering/theme/theme_controller.dart';

class ThemeToggleButton extends StatelessWidget {
  const ThemeToggleButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.brightness_medium),
      onPressed: ThemeController.toggle,
    );
  }
}
