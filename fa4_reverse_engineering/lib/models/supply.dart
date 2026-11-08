import 'package:fa4_reverse_engineering/models/parameter.dart';

class Supply {
  Supply({
    required this.id,
    required this.name,
    required this.quantity,
    required this.unitPrice,
    required this.category,
  });

  final String id;
  final String name;
  final int quantity;
  final double unitPrice;
  final Parameter category;

  double get total => unitPrice * quantity;
}