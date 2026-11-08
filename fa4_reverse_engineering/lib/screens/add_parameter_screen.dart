import 'package:flutter/material.dart';
import 'package:fa4_reverse_engineering/constants/app_sizes.dart';
import 'package:fa4_reverse_engineering/constants/app_strings.dart';
import 'package:fa4_reverse_engineering/models/parameter.dart';
import 'package:fa4_reverse_engineering/utils/validators.dart';
import 'package:fa4_reverse_engineering/widgets/color_wheel.dart';
import 'package:fa4_reverse_engineering/widgets/underline_text_field.dart';

class AddParameterScreen extends StatefulWidget {
  const AddParameterScreen({super.key});

  @override
  State<AddParameterScreen> createState() => _AddParameterScreenState();
}

class _AddParameterScreenState extends State<AddParameterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _classController = TextEditingController();
  WheelSelection? _selection;

  @override
  void dispose() {
    _nameController.dispose();
    _classController.dispose();
    super.dispose();
  }

  Color get _color => _selection?.color ?? Colors.black;

  String get _hex =>
      _color.value.toRadixString(16).toUpperCase().padLeft(8, '0');

  void _reset() {
    _formKey.currentState!.reset();
    setState(() {
      _nameController.clear();
      _classController.clear();
      _selection = null;
    });
  }

  void _addParameter() {
    if (!_formKey.currentState!.validate()) return;

    final parameter = Parameter(
      name: _nameController.text.trim(),
      className: _classController.text.trim().toUpperCase(),
      color: _color,
    );
    Navigator.of(context).pop(parameter);
  }

  Widget _nameField() {
    return UnderlineTextField(
      label: 'Parameter Name',
      controller: _nameController,
      maxLength: kMaxNameLength,
      validator: requiredField(kEnterParameterName),
    );
  }

  Widget _classField() {
    return UnderlineTextField(
      label: 'Parameter Class',
      controller: _classController,
      maxLength: kMaxNameLength,
      validator: requiredField(kEnterParameterClass),
    );
  }

  Widget _wheelSection() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ColorWheel(
          selection: _selection,
          onChanged: (value) {
            setState(() {
              _selection = value;
            });
          },
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: kColorBoxSize,
              height: kColorBoxSize,
              color: _color,
            ),
            const SizedBox(width: 2),
            Text(_hex, style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
      ],
    );
  }

  Widget _buttons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(onPressed: _reset, child: const Text('Reset')),
        const SizedBox(width: 8),
        FilledButton(
          onPressed: _addParameter,
          child: const Text('Add Parameter'),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add a new parameter')),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isWide = constraints.maxWidth >= kWideBreakpoint;

          return SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(
              kCompactPadding,
              0,
              kCompactPadding,
              kCompactPadding,
            ),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  _nameField(),
                  const SizedBox(height: kFieldSpacing),
                  if (isWide)
                    IntrinsicHeight(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Expanded(
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: _classField(),
                            ),
                          ),
                          Expanded(child: _wheelSection()),
                        ],
                      ),
                    )
                  else ...[
                    _classField(),
                    const SizedBox(height: kSectionSpacing),
                    _wheelSection(),
                  ],
                  const SizedBox(height: kFieldSpacing),
                  _buttons(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}