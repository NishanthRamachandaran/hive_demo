import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_flutter_example/domains/models/repositories/expense_repository.dart';
import 'application/expense_notifier.dart';
import 'presentation/screens/expense_home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  final box = await Hive.openBox('expenses');

  runApp(ProviderScope(
    overrides: [
      expenseRepoProvider.overrideWithValue(ExpenseRepository(box)),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ExpenseHome(),
    );
  }
}
