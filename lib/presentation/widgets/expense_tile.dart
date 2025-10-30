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
    final isIncome = expense.type == ExpenseType.income;
    
    return ListTile(
      leading: Icon(
        isIncome ? Icons.arrow_upward : Icons.arrow_downward,
        color: isIncome ? Colors.green : Colors.red,
      ),
      title: Text("${expense.title} - ₹${expense.amount.toStringAsFixed(2)}"),
      subtitle: Text("${expense.category} • ${_formatDate(expense.date)}"),
      trailing: IconButton(
        icon: const Icon(Icons.delete, color: Colors.red),
        onPressed: () => _showDeleteConfirmation(context),
      ),
      tileColor: isIncome ? Colors.green.withOpacity(0.1) : null,
    );
  }

  String _formatDate(DateTime date) {
    return "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')} ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}";
  }

  void _showDeleteConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Expense?'),
        content: Text('Are you sure you want to delete "${expense.title}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              onDelete();
            },
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}