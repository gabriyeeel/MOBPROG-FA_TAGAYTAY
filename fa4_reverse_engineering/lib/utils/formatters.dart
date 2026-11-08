String formatAmount(double value) {
  final rounded = double.parse(value.toStringAsFixed(2));
  final text = rounded == rounded.roundToDouble()
      ? rounded.toInt().toString()
      : rounded.toString();
  return '\$$text';
}
