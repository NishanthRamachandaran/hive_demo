import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_flutter_example/domains/models/repositories/expense_repository.dart';
import 'package:hive_flutter_example/localization/locale_notifier.dart';
import 'package:hive_flutter_example/presentation/screens/expense_home.dart';
import 'application/expense_notifier.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  final expenseBox = await Hive.openBox('expenses');
  await Hive.openBox('settings');

  runApp(ProviderScope(
    overrides: [expenseRepoProvider.overrideWithValue(ExpenseRepository(expenseBox))],
    child: const MyApp(),
  ));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = ref.watch(localeNotifierProvider);
    
    return MaterialApp(debugShowCheckedModeBanner: false,
      locale: locale,
      supportedLocales: const [
        Locale('en'),
        Locale('ar'),
      ],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      builder: (context, child) {
        return Directionality(
          textDirection: TextDirection.ltr, 
          child: child!,
        );
      },
      home: const ExpenseHome(),
    );
  }
}