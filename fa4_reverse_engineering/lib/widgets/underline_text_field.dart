import 'package:flutter/material.dart';

class UnderlineTextField extends StatelessWidget {
  const UnderlineTextField({
    super.key,
    required this.label,
    required this.controller,
    this.validator,
    this.maxLength,
    this.onChanged,
  });

  final String label;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final int? maxLength;
  final void Function(String)? onChanged;

  UnderlineInputBorder _line(Color color, [double width = 1]) {
    return UnderlineInputBorder(
      borderSide: BorderSide(color: color, width: width),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return TextFormField(
      controller: controller,
      validator: validator,
      maxLength: maxLength,
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: label,
        border: _line(colors.outline),
        enabledBorder: _line(colors.outline),
        focusedBorder: _line(colors.primary, 2),
        errorBorder: _line(colors.error),
        focusedErrorBorder: _line(colors.error, 2),
      ),
    );
  }
}