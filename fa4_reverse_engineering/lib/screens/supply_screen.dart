import 'package:flutter/material.dart';
import 'package:fa4_reverse_engineering/constants/app_sizes.dart';
import 'package:fa4_reverse_engineering/constants/app_strings.dart';
import 'package:fa4_reverse_engineering/data/parameter_repository.dart';
import 'package:fa4_reverse_engineering/data/supply_repository.dart';
import 'package:fa4_reverse_engineering/models/supply.dart';
import 'package:fa4_reverse_engineering/screens/add_supply_screen.dart';
import 'package:fa4_reverse_engineering/widgets/supply_chart.dart';
import 'package:fa4_reverse_engineering/widgets/supply_item.dart';

class SupplyScreen extends StatefulWidget {
  const SupplyScreen({super.key});

  @override
  State<SupplyScreen> createState() => _SupplyScreenState();
}

class _SupplyScreenState extends State<SupplyScreen> {
  Future<void> _openAddSupply() async {
    final newSupply = await Navigator.of(
      context,
    ).push<Supply>(MaterialPageRoute(builder: (_) => const AddSupplyScreen()));
    if (newSupply == null) return;

    setState(() {
      SupplyRepository.supplies.add(newSupply);
    });
  }

  void _removeSupply(Supply supply) {
    final index = SupplyRepository.supplies.indexOf(supply);
    setState(() {
      SupplyRepository.supplies.remove(supply);
    });

    final messenger = ScaffoldMessenger.of(context);
    messenger.clearSnackBars();
    messenger.showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        content: const Text(kSupplyDeleted),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              SupplyRepository.supplies.insert(index, supply);
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final supplies = SupplyRepository.supplies;
    final colors = Theme.of(context).colorScheme;

    // same look for both swipe directions
    final swipeBackground = Container(
      margin: const EdgeInsets.symmetric(
        horizontal: kScreenPadding,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        color: colors.errorContainer,
        borderRadius: BorderRadius.circular(kCardRadius),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Supply Manager'),
        actions: [
          IconButton(icon: const Icon(Icons.add), onPressed: _openAddSupply),
        ],
      ),
      body: Column(
        children: [
          SupplyChart(
            supplies: supplies,
            parameters: ParameterRepository.parameters,
          ),
          Expanded(
            child: supplies.isEmpty
                ? Center(
                    child: Text(
                      kNoSupplies,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  )
                : ListView.builder(
                    itemCount: supplies.length,
                    itemBuilder: (context, index) {
                      final supply = supplies[index];
                      return Dismissible(
                        key: ValueKey(supply.id),
                        direction: DismissDirection.horizontal,
                        background: swipeBackground,
                        secondaryBackground: swipeBackground,
                        onDismissed: (_) => _removeSupply(supply),
                        child: SupplyItem(supply: supply),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
