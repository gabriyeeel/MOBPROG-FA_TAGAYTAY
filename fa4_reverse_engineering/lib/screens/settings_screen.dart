import 'package:flutter/material.dart';
import 'package:fa4_reverse_engineering/constants/app_strings.dart';
import 'package:fa4_reverse_engineering/data/parameter_repository.dart';
import 'package:fa4_reverse_engineering/models/parameter.dart';
import 'package:fa4_reverse_engineering/screens/add_parameter_screen.dart';
import 'package:fa4_reverse_engineering/widgets/parameter_item.dart';
import 'package:fa4_reverse_engineering/widgets/underline_text_field.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final _searchController = TextEditingController();
  String _query = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _openAddParameter() async {
    final newParameter = await Navigator.of(context).push<Parameter>(
      MaterialPageRoute(builder: (_) => const AddParameterScreen()),
    );
    if (newParameter == null) return;

    setState(() {
      ParameterRepository.add(newParameter);
    });
  }

  @override
  Widget build(BuildContext context) {
    final query = _query.trim().toUpperCase();
    final shown = ParameterRepository.parameters
        .where(
          (p) =>
              p.className.toUpperCase().contains(query) ||
              p.name.toUpperCase().contains(query),
        )
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Parameter Settings'),
        actions: [
          IconButton(icon: const Icon(Icons.add), onPressed: _openAddParameter),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: UnderlineTextField(
              label: 'Search by Class',
              controller: _searchController,
              onChanged: (value) {
                setState(() {
                  _query = value;
                });
              },
            ),
          ),
          Expanded(
            child: shown.isEmpty
                ? Center(
                    child: Text(
                      kNoParameters,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  )
                : ListView.builder(
                    itemCount: shown.length,
                    itemBuilder: (context, index) =>
                        ParameterItem(parameter: shown[index]),
                  ),
          ),
        ],
      ),
    );
  }
}
