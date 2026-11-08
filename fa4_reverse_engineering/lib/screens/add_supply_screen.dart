import 'package:flutter/material.dart';
import 'package:fa4_reverse_engineering/constants/app_sizes.dart';
import 'package:fa4_reverse_engineering/constants/app_strings.dart';
import 'package:fa4_reverse_engineering/data/parameter_repository.dart';
import 'package:fa4_reverse_engineering/models/parameter.dart';
import 'package:fa4_reverse_engineering/models/supply.dart';
import 'package:fa4_reverse_engineering/theme/app_theme.dart';
import 'package:fa4_reverse_engineering/utils/validators.dart';
import 'package:fa4_reverse_engineering/widgets/app_text_field.dart';
import 'package:fa4_reverse_engineering/widgets/category_tag.dart';
import 'package:fa4_reverse_engineering/widgets/quantity_field.dart';
import 'package:fa4_reverse_engineering/widgets/styled_button.dart';

class AddSupplyScreen extends StatefulWidget {
  const AddSupplyScreen({super.key});

  @override
  State<AddSupplyScreen> createState() => _AddSupplyScreenState();
}

class _AddSupplyScreenState extends State<AddSupplyScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _quantityController = TextEditingController(text: '1');
  final _priceController = TextEditingController(text: '1.00');
  Parameter? _category;

  @override
  void initState() {
    super.initState();
    final parameters = ParameterRepository.parameters;
    _category = parameters.isEmpty ? null : parameters.first;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _quantityController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  void _changeQuantity(int change) {
    final current = int.tryParse(_quantityController.text) ?? 1;
    final updated = current + change;
    _quantityController.text = (updated < 1 ? 1 : updated).toString();
  }

  String? _validateQuantity(String? value) {
    final quantity = int.tryParse(value ?? '');
    if (quantity == null || quantity < 1) return kInvalidQuantity;
    return null;
  }

  String? _validatePrice(String? value) {
    if (double.tryParse(value ?? '') == null) return kInvalidPrice;
    return null;
  }

  void _save() {
    if (!_formKey.currentState!.validate()) return;

    final supply = Supply(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      name: _nameController.text.trim(),
      quantity: int.parse(_quantityController.text),
      unitPrice: double.parse(_priceController.text),
      category: _category!,
    );
    Navigator.of(context).pop(supply);
  }

  @override
  Widget build(BuildContext context) {
    final parameters = ParameterRepository.parameters;

    return Scaffold(
      appBar: AppBar(title: const Text('Add a new supply')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(kScreenPadding),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(height: kSectionSpacing),
              AppTextField(
                label: 'Item Name',
                controller: _nameController,
                validator: requiredField(kEnterItemName),
              ),
              const SizedBox(height: kFieldSpacing),
              QuantityField(
                controller: _quantityController,
                onChanged: _changeQuantity,
                validator: _validateQuantity,
              ),
              const SizedBox(height: kFieldSpacing),
              TextFormField(
                controller: _priceController,
                validator: _validatePrice,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                  signed: true,
                ),
                decoration: const InputDecoration(
                  labelText: 'Unit Price',
                  prefixText: '\$ ',
                ),
              ),
              const SizedBox(height: kFieldSpacing),
              DropdownButtonFormField<Parameter>(
                value: _category,
                isExpanded: true,
                dropdownColor: menuColor(context),
                decoration: const InputDecoration(labelText: 'Supply Category'),
                validator: (value) => value == null ? kSelectCategory : null,
                items: [
                  for (final parameter in parameters)
                    DropdownMenuItem(
                      value: parameter,
                      child: CategoryTag(category: parameter, uppercase: true),
                    ),
                ],
                onChanged: (value) {
                  if (value == null) return;
                  setState(() {
                    _category = value;
                  });
                },
              ),
              const SizedBox(height: kFieldSpacing),
              StyledButton(label: 'Save', onPressed: _save),
            ],
          ),
        ),
      ),
    );
  }
}