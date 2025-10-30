import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter_example/domains/models/expense.dart';
import 'package:hive_flutter_example/domains/models/repositories/expense_repository.dart';

final expenseRepoProvider =
    Provider<ExpenseRepository>((ref) => throw UnimplementedError());

final expenseListProvider =
    StateNotifierProvider<ExpenseNotifier, List<Expense>>((ref) {
  final repo = ref.watch(expenseRepoProvider);
  return ExpenseNotifier(repo);
});

class ExpenseNotifier extends StateNotifier<List<Expense>> {
  final ExpenseRepository repo;
  ExpenseNotifier(this.repo) : super([]) {
    load();
  }

  void load() {
    state = repo.getAll();
  }

  Future<void> add(String title, double amount, String category,
      {ExpenseType type = ExpenseType.expense}) async {
    final e = Expense(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title,
      amount: amount,
      category: category,
      date: DateTime.now(),
      type: type,
    );
    await repo.addExpense(e);
    load();
  }

  Future<void> delete(String id) async {
    await repo.deleteExpense(id);
    load();
  }
}