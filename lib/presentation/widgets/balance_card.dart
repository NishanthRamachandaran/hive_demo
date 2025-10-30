import 'package:flutter/material.dart';
import 'package:hive_flutter_example/localization/app_localization.dart';

class BalanceCard extends StatelessWidget {
  final double balance;
  final double totalIncome;
  final double totalExpenses;

  const BalanceCard({
    super.key,
    required this.balance,
    required this.totalIncome,
    required this.totalExpenses,
  });

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);

    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              loc.balance,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Text(
              "₹${balance.toStringAsFixed(2)}",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: balance >= 0 ? Colors.green : Colors.red,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Text(loc.income),
                    Text(
                      "₹${totalIncome.toStringAsFixed(2)}",
                      style: const TextStyle(color: Colors.green),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(loc.expense),
                    Text(
                      "₹${totalExpenses.toStringAsFixed(2)}",
                      style: const TextStyle(color: Colors.red),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}