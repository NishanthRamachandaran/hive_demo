import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter_example/domains/models/expense.dart';
import 'package:hive_flutter_example/localization/app_localization.dart';
import 'package:hive_flutter_example/presentation/widgets/expense_tile.dart';
import 'package:hive_flutter_example/application/expense_notifier.dart';

class ExpenseList extends ConsumerWidget {
  final List<Expense> expenses;

  const ExpenseList({
    super.key,
    required this.expenses,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loc = AppLocalizations.of(context);

    return Expanded(
      child: RefreshIndicator(
        onRefresh: () async {
          ref.read(expenseListProvider.notifier).load();
        },
        child: expenses.isEmpty
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.money_off,
                      size: 64,
                      color: Colors.grey[400],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      loc.noData,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Pull down to refresh',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              )
            : ListView.builder(
                itemCount: expenses.length,
                itemBuilder: (context, i) {
                  final e = expenses[i];
                  return ExpenseTile(
                    expense: e,
                    onDelete: () =>
                        ref.read(expenseListProvider.notifier).delete(e.id),
                  );
                },
              ),
      ),
    );
  }
}