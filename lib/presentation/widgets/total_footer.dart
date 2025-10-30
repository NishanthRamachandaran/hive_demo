import 'package:flutter/material.dart';
import 'package:hive_flutter_example/domains/models/expense.dart';
import 'package:hive_flutter_example/localization/app_localization.dart';

class TotalFooter extends StatelessWidget {
  final double totalExpenses;
  final double totalIncome;
  final ExpenseType selectedType; 
  const TotalFooter({
    super.key,
    required this.totalExpenses,
    required this.totalIncome, 
    required this.selectedType, 
  });

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    
    // Determine which total to show and what color to use
    final double totalAmount = selectedType == ExpenseType.income ? totalIncome : totalExpenses;
    final Color amountColor = selectedType == ExpenseType.income ? Colors.green : Colors.red;
    final String label = selectedType == ExpenseType.income ? loc.income : loc.expense;

    return Container(
      color: const Color.fromARGB(255, 134, 134, 134),
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "${loc.total} $label: ",
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            "₹${totalAmount.toStringAsFixed(2)}",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: amountColor, 
            ),
          ),
        ],
      ),
    );
  }
}