import 'package:flutter/material.dart';
import 'package:hive_flutter_example/domains/models/expense.dart';
import 'package:hive_flutter_example/localization/app_localization.dart';

class AddExpenseForm extends StatelessWidget {
  final TextEditingController titleCtrl;
  final TextEditingController amountCtrl;
  final TextEditingController categoryCtrl;
  final ExpenseType selectedType;
  final VoidCallback onAddExpense;

  const AddExpenseForm({
    super.key,
    required this.titleCtrl,
    required this.amountCtrl,
    required this.categoryCtrl,
    required this.selectedType,
    required this.onAddExpense,
  });

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);

    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          TextField(
            controller: titleCtrl,
            decoration: InputDecoration(labelText: loc.titleHint),
          ),
          TextField(
            controller: amountCtrl,
            decoration: InputDecoration(labelText: loc.amountHint),
            keyboardType: TextInputType.number,
          ),
          TextField(
            controller: categoryCtrl,
            decoration: InputDecoration(
              labelText: loc.categoryHint,
              hintText: selectedType == ExpenseType.income
                  ? loc.income
                  : loc.general,
            ),
          ),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: onAddExpense,
            child: Text(
              selectedType == ExpenseType.income
                  ? loc.addIncome
                  : loc.addExpense,
            ),
          ),
        ],
      ),
    );
  }
}