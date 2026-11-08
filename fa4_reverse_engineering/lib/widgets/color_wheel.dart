import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:fa4_reverse_engineering/constants/app_colors.dart';
import 'package:fa4_reverse_engineering/constants/app_sizes.dart';

class WheelSelection {
  const WheelSelection({required this.angle, required this.distance});

  final double angle;
  final double distance;

  Color get color {
    final position = angle / (2 * math.pi) * (kWheelColors.length - 1);
    int index = position.floor();
    if (index < 0) index = 0;
    if (index > kWheelColors.length - 2) index = kWheelColors.length - 2;

    final base = Color.lerp(
      kWheelColors[index],
      kWheelColors[index + 1],
      position - index,
    )!;
    return Color.lerp(Colors.white, base, distance)!;
  }
}

class ColorWheel extends StatelessWidget {
  const ColorWheel({
    super.key,
    required this.selection,
    required this.onChanged,
    this.size = kWheelSize,
  });

  final WheelSelection? selection;
  final ValueChanged<WheelSelection> onChanged;
  final double size;

  void _pick(Offset position) {
    final radius = size / 2;
    final dx = position.dx - radius;
    final dy = position.dy - radius;

    final distance = math.sqrt(dx * dx + dy * dy) / radius;

    double angle = math.atan2(dy, dx);
    if (angle < 0) angle += 2 * math.pi;

    onChanged(
      WheelSelection(angle: angle, distance: distance.clamp(0.0, 1.0).toDouble()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanDown: (details) => _pick(details.localPosition),
      onPanUpdate: (details) => _pick(details.localPosition),
      child: CustomPaint(
        size: Size(size, size),
        painter: _WheelPainter(selection),
      ),
    );
  }
}

class _WheelPainter extends CustomPainter {
  _WheelPainter(this.selection);

  final WheelSelection? selection;

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final radius = size.width / 2;
    final rect = Rect.fromCircle(center: center, radius: radius);

    canvas.drawCircle(
      center,
      radius,
      Paint()
        ..shader = const SweepGradient(colors: kWheelColors).createShader(rect),
    );

    canvas.drawCircle(
      center,
      radius,
      Paint()
        ..shader = RadialGradient(
          colors: [Colors.white, Colors.white.withOpacity(0)],
        ).createShader(rect),
    );

    Offset handle = center;
    if (selection != null) {
      handle = center +
          Offset(math.cos(selection!.angle), math.sin(selection!.angle)) *
              (selection!.distance * radius);
    }
    canvas.drawCircle(
      handle,
      kWheelHandleRadius,
      Paint()
        ..color = Colors.white
        ..style = PaintingStyle.stroke
        ..strokeWidth = 3,
    );
  }

  @override
  bool shouldRepaint(covariant _WheelPainter oldDelegate) =>
      oldDelegate.selection != selection;
}