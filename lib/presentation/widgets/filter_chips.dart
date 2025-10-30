import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter_example/domains/models/expense.dart';
import 'package:hive_flutter_example/localization/app_localization.dart';
import 'package:hive_flutter_example/core/providers/expense_filter_notifier.dart';

class FilterChips extends ConsumerWidget {
  const FilterChips({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filter = ref.watch(expenseFilterProvider);
    final loc = AppLocalizations.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            FilterChip(
              label: Text(loc.general),
              selected: filter == null,
              onSelected: (_) => ref.read(expenseFilterProvider.notifier).state = null,
            ),
            const SizedBox(width: 8),
            FilterChip(
              label: Text('All Income'),
              selected: filter == ExpenseType.income,
              onSelected: (_) => ref.read(expenseFilterProvider.notifier).state = ExpenseType.income,
            ),
            const SizedBox(width: 8),
            FilterChip(
              label: Text('All Expenses'),
              selected: filter == ExpenseType.expense,
              onSelected: (_) => ref.read(expenseFilterProvider.notifier).state = ExpenseType.expense,
            ),
          ],
        ),
      ),
    );
  }
}