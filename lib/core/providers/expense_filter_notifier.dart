import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter_example/application/expense_notifier.dart';
import 'package:hive_flutter_example/domains/models/expense.dart';

final expenseFilterProvider = StateProvider<ExpenseType?>((ref) => null);

final filteredExpensesProvider = Provider<List<Expense>>((ref) {
  final expenses = ref.watch(expenseListProvider);
  final filter = ref.watch(expenseFilterProvider);
  
  if (filter == null) return expenses;
  return expenses.where((expense) => expense.type == filter).toList();
});