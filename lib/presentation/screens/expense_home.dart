import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../application/expense_notifier.dart';
import '../widgets/expense_tile.dart';
import '../../localization/app_localizations.dart';
import '../../localization/locale_notifier.dart';
import '../../localization/locale_constants.dart';

class ExpenseHome extends ConsumerWidget {
  const ExpenseHome({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final expenses = ref.watch(expenseListProvider);
    final locale = ref.watch(localeNotifierProvider);
    final notifier = ref.read(localeNotifierProvider.notifier);
    final loc = AppLocalizations(locale);
    
    final titleCtrl = TextEditingController();
    final amountCtrl = TextEditingController();
    final categoryCtrl = TextEditingController();

    double total = expenses.fold(0, (sum, e) => sum + e.amount);

    return Scaffold(
      appBar: AppBar(
        title: Text(loc.title),
        actions: [
          DropdownButton<String>(
            value: locale.languageCode,
            items: supportedLanguages
                .map((lang) => DropdownMenuItem(
                      value: lang['code'],
                      child: Text(lang['name']!),
                    ))
                .toList(),
            onChanged: (code) {
              if (code != null) notifier.changeLanguage(code);
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: expenses.length,
              itemBuilder: (context, i) {
                final e = expenses[i];
                return ExpenseTile(
                  expense: e,
                  onDelete: () => ref.read(expenseListProvider.notifier).delete(e.id),
                );
              },
            ),
          ),
          Container(
            color: Colors.grey.shade200,
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("${loc.total}: ", 
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Text("₹${total.toStringAsFixed(2)}", 
                    style: const TextStyle(fontSize: 18)),
              ],
            ),
          ),
          Padding(
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
                  decoration: InputDecoration(labelText: loc.categoryHint),
                ),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () {
                    if (titleCtrl.text.isNotEmpty && amountCtrl.text.isNotEmpty) {
                      ref.read(expenseListProvider.notifier).add(
                            titleCtrl.text,
                            double.tryParse(amountCtrl.text) ?? 0,
                            categoryCtrl.text.isEmpty ? loc.general : categoryCtrl.text,
                          );
                      titleCtrl.clear();
                      amountCtrl.clear();
                      categoryCtrl.clear();
                    }
                  },
                  child: Text(loc.addExpense),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}