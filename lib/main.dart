import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_flutter_example/domains/models/repositories/expense_repository.dart';
import 'package:hive_flutter_example/localization/app_localization.dart';

import 'core/providers/locale_notifier.dart';
import 'core/providers/theme_notifier.dart';
import 'presentation/screens/expense_home.dart';
import 'application/expense_notifier.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  final expenseBox = await Hive.openBox('expenses');
  await Hive.openBox('settings');

  runApp(ProviderScope(
    overrides: [
      expenseRepoProvider.overrideWithValue(ExpenseRepository(expenseBox))
    ],
    child: const MyApp(),
  ));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = ref.watch(localeNotifierProvider);
    final isDarkMode = ref.watch(themeNotifierProvider); // Now this is a boolean
    
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      locale: locale,
      theme: ThemeData.light(), // Light theme
      darkTheme: ThemeData.dark(), // Dark theme
      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light, // Convert boolean to ThemeMode
      supportedLocales: const [
        Locale('en'),
        Locale('ar'),
        Locale('hi'), 
        Locale('ta'),
      ],
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      builder: (context, child) {
        final isRTL = locale.languageCode == 'ar';
        return Directionality(
          textDirection: isRTL ? TextDirection.rtl : TextDirection.ltr,
          child: child!,
        );
      },
      home: const ExpenseHome(),
    );
  }
}