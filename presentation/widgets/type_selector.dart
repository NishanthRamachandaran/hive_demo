import 'package:flutter/material.dart';
import 'package:hive_flutter_example/domains/models/expense.dart';
import 'package:hive_flutter_example/localization/app_localization.dart';

class TypeSelector extends StatelessWidget {
  final ExpenseType selectedType;
  final Function(ExpenseType) onTypeChanged;

  const TypeSelector({
    super.key,
    required this.selectedType,
    required this.onTypeChanged,
  });

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SegmentedButton<ExpenseType>(
        segments: [
          ButtonSegment(
            value: ExpenseType.expense,
            label: Text(loc.expense),
            icon: const Icon(Icons.arrow_downward),
          ),
          ButtonSegment(
            value: ExpenseType.income,
            label: Text(loc.income),
            icon: const Icon(Icons.arrow_upward),
          ),
        ],
        selected: {selectedType},
        onSelectionChanged: (Set<ExpenseType> newSelection) {
          onTypeChanged(newSelection.first);
        },
      ),
    );
  }
}