import 'package:flutter/material.dart';
import 'package:fa4_reverse_engineering/widgets/firefly_logo.dart';

class FireflyLogoBox extends StatelessWidget {
  const FireflyLogoBox({super.key, required this.height});

  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: double.infinity,
      child: const FireflyLogo(),
    );
  }
}