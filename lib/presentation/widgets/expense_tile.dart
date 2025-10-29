import 'package:flutter/material.dart';
import 'package:hive_flutter_example/domains/models/expense.dart';

class ExpenseTile extends StatelessWidget {
  final Expense expense;
  final VoidCallback onDelete;
  
  const ExpenseTile({
    super.key, 
    required this.expense, 
    required this.onDelete
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text("${expense.title} - ₹${expense.amount.toStringAsFixed(2)}"),
      subtitle: Text("${expense.category} • ${_formatDate(expense.date)}"),
      trailing: IconButton(
        icon: const Icon(Icons.delete, color: Colors.red),
        onPressed: onDelete,
      ),
    );
  }

  String _formatDate(DateTime date) {
    return "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')} ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}";
  }
}