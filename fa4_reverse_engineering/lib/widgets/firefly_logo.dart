import 'package:flutter/material.dart';
import 'package:fa4_reverse_engineering/constants/app_assets.dart';

class FireflyLogo extends StatelessWidget {
  const FireflyLogo({super.key, this.width, this.height});

  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      kLogoAsset,
      width: width,
      height: height,
      fit: BoxFit.contain,
      color: Theme.of(context).colorScheme.primary,
      colorBlendMode: BlendMode.srcIn,
    );
  }
}
