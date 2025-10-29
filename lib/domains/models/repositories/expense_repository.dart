import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_flutter_example/domains/models/expense.dart';

class ExpenseRepository {
  final Box _box;
  ExpenseRepository(this._box);

  Future<void> addExpense(Expense e) async => _box.put(e.id, e.toJson());

  List<Expense> getAll() => _box.values
      .map((e) => Expense.fromJson(Map<String, dynamic>.from(e)))
      .toList();

  Future<void> deleteExpense(String id) async => _box.delete(id);
}
