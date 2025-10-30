import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter_example/domains/models/expense.dart';
import 'package:hive_flutter_example/localization/app_localization.dart';
import 'package:hive_flutter_example/application/expense_notifier.dart';
import 'package:hive_flutter_example/core/providers/locale_notifier.dart';
import 'package:hive_flutter_example/core/constants/locale_constants.dart';
import 'package:hive_flutter_example/presentation/widgets/add_expense_form.dart';
import 'package:hive_flutter_example/presentation/widgets/balance_card.dart';
import 'package:hive_flutter_example/presentation/widgets/expense_list.dart';
import 'package:hive_flutter_example/presentation/widgets/total_footer.dart';
import 'package:hive_flutter_example/presentation/widgets/type_selector.dart';

import 'settings_screen.dart';

class ExpenseHome extends ConsumerStatefulWidget {
  const ExpenseHome({super.key});

  @override
  ConsumerState<ExpenseHome> createState() => _ExpenseHomeState();
}

class _ExpenseHomeState extends ConsumerState<ExpenseHome> {
  final TextEditingController _titleCtrl = TextEditingController();
  final TextEditingController _amountCtrl = TextEditingController();
  final TextEditingController _categoryCtrl = TextEditingController();

  ExpenseType _selectedType = ExpenseType.expense;

  @override
  void dispose() {
    _titleCtrl.dispose();
    _amountCtrl.dispose();
    _categoryCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final expenses = ref.watch(expenseListProvider);
    final locale = ref.watch(localeNotifierProvider);
    final notifier = ref.read(localeNotifierProvider.notifier);
    final loc = AppLocalizations.of(context);

    double totalExpenses = expenses
        .where((e) => e.type == ExpenseType.expense)
        .fold(0, (sum, e) => sum + e.amount);
    double totalIncome = expenses
        .where((e) => e.type == ExpenseType.income)
        .fold(0, (sum, e) => sum + e.amount);
    double balance = totalIncome - totalExpenses;

    return Scaffold(
      appBar: AppBar(
        title: Text(loc.title),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SettingsScreen()),
              );
            },
          ),
          DropdownButton<String>(
            value: locale.languageCode,
            items: LocaleConstants.supportedLanguages
                .map(
                  (lang) => DropdownMenuItem(
                    value: lang['code'],
                    child: Text(lang['name']!),
                  ),
                )
                .toList(),
            onChanged: (code) {
              if (code != null) notifier.changeLanguage(code);
            },
          ),
        ],
      ),
      body: Column(
        children: [
          BalanceCard(
            balance: balance,
            totalIncome: totalIncome,
            totalExpenses: totalExpenses,
          ),

          TypeSelector(
            selectedType: _selectedType,
            onTypeChanged: (newType) {
              setState(() {
                _selectedType = newType;
              });
            },
          ),

          ExpenseList(expenses: expenses),
          TotalFooter(
            totalExpenses: totalExpenses,
            totalIncome: totalIncome,
            selectedType: _selectedType,
          ),

          AddExpenseForm(
            titleCtrl: _titleCtrl,
            amountCtrl: _amountCtrl,
            categoryCtrl: _categoryCtrl,
            selectedType: _selectedType,
            onAddExpense: () {
              if (_titleCtrl.text.isNotEmpty && _amountCtrl.text.isNotEmpty) {
                final category = _categoryCtrl.text.isEmpty
                    ? (_selectedType == ExpenseType.income
                          ? loc.income
                          : loc.general)
                    : _categoryCtrl.text;

                ref
                    .read(expenseListProvider.notifier)
                    .add(
                      _titleCtrl.text,
                      double.tryParse(_amountCtrl.text) ?? 0,
                      category,
                      type: _selectedType,
                    );
                _titleCtrl.clear();
                _amountCtrl.clear();
                _categoryCtrl.clear();
              }
            },
          ),
        ],
      ),
    );
  }
}
