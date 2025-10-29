import 'package:flutter/material.dart';

class AppLocalizations {
  final Locale locale;
  AppLocalizations(this.locale);

  static Map<String, Map<String, String>> _localizedValues = {
    'en': {
      'title': 'Expense Tracker',
      'addExpense': 'Add Expense',
      'total': 'Total',
      'titleHint': 'Title',
      'amountHint': 'Amount',
      'categoryHint': 'Category',
      'delete': 'Delete',
      'general': 'General',
    },
    'ar': {
      'title': 'متعقب المصاريف',
      'addExpense': 'أضف مصروف',
      'total': 'المجموع',
      'titleHint': 'العنوان',
      'amountHint': 'المبلغ',
      'categoryHint': 'الفئة',
      'delete': 'حذف',
      'general': 'عام',
    },
  };

  String get title => _localizedValues[locale.languageCode]!['title']!;
  String get addExpense => _localizedValues[locale.languageCode]!['addExpense']!;
  String get total => _localizedValues[locale.languageCode]!['total']!;
  String get titleHint => _localizedValues[locale.languageCode]!['titleHint']!;
  String get amountHint => _localizedValues[locale.languageCode]!['amountHint']!;
  String get categoryHint => _localizedValues[locale.languageCode]!['categoryHint']!;
  String get delete => _localizedValues[locale.languageCode]!['delete']!;
  String get general => _localizedValues[locale.languageCode]!['general']!;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }
}