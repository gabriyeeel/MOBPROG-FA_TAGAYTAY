import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class QuantityField extends StatelessWidget {
  const QuantityField({
    super.key,
    required this.controller,
    required this.onChanged,
    this.validator,
  });

  final TextEditingController controller;
  final void Function(int change) onChanged;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      textAlign: TextAlign.center,
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      decoration: InputDecoration(
        labelText: 'Item Quantity',
        prefixIcon: IconButton(
          icon: const Icon(Icons.remove),
          onPressed: () => onChanged(-1),
        ),
        suffixIcon: IconButton(
          icon: const Icon(Icons.add),
          onPressed: () => onChanged(1),
        ),
      ),
    );
  }
}
