import 'package:flutter/material.dart';

class AppLocalizations {
  final Locale locale;
  AppLocalizations(this.locale);

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

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
      'addIncome': 'Add Income',
      'income': 'Income',
      'expense': 'Expense',
      'balance': 'Balance',
      'settings': 'Settings',
      'statistics': 'Statistics',
      'noData': 'No data',
      'language': 'Language',
      'theme': 'Theme',
      'darkMode': 'Dark Mode',
      'about': 'About',
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
      'addIncome': 'أضف دخل',
      'income': 'دخل',
      'expense': 'مصروف',
      'balance': 'الرصيد',
      'settings': 'الإعدادات',
      'statistics': 'الإحصائيات',
      'noData': 'لا توجد بيانات',
      'language': 'اللغة',
      'theme': 'المظهر',
      'darkMode': 'الوضع الداكن',
      'about': 'حول',
    },
    'hi': {
      'title': 'खर्च ट्रैकर',
      'addExpense': 'खर्च जोड़ें',
      'total': 'कुल',
      'titleHint': 'शीर्षक',
      'amountHint': 'राशि',
      'categoryHint': 'श्रेणी',
      'delete': 'हटाएं',
      'general': 'सामान्य',
      'addIncome': 'आय जोड़ें',
      'income': 'आय',
      'expense': 'खर्च',
      'balance': 'शेष',
      'settings': 'सेटिंग्स',
      'statistics': 'आंकड़े',
      'noData': 'कोई डेटा नहीं',
      'language': 'भाषा',
      'theme': 'थीम',
      'darkMode': 'डार्क मोड',
      'about': 'के बारे में',
    },
    'ta': {
      'title': 'செலவு கண்காணிப்பான்',
      'addExpense': 'செலவைச் சேர்',
      'total': 'மொத்தம்',
      'titleHint': 'தலைப்பு',
      'amountHint': 'தொகை',
      'categoryHint': 'வகை',
      'delete': 'நீக்கு',
      'general': 'பொது',
      'addIncome': 'வருமானத்தைச் சேர்',
      'income': 'வருமானம்',
      'expense': 'செலவு',
      'balance': 'இருப்பு',
      'settings': 'அமைப்புகள்',
      'statistics': 'புள்ளிவிவரங்கள்',
      'noData': 'தரவு இல்லை',
      'language': 'மொழி',
      'theme': 'தீம்',
      'darkMode': 'டார்க் மோட்',
      'about': 'பற்றி',
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
  String get addIncome => _localizedValues[locale.languageCode]!['addIncome']!;
  String get income => _localizedValues[locale.languageCode]!['income']!;
  String get expense => _localizedValues[locale.languageCode]!['expense']!;
  String get balance => _localizedValues[locale.languageCode]!['balance']!;
  String get settings => _localizedValues[locale.languageCode]!['settings']!;
  String get statistics => _localizedValues[locale.languageCode]!['statistics']!;
  String get noData => _localizedValues[locale.languageCode]!['noData']!;
  String get language => _localizedValues[locale.languageCode]!['language']!;
  String get theme => _localizedValues[locale.languageCode]!['theme']!;
  String get darkMode => _localizedValues[locale.languageCode]!['darkMode']!;
  String get about => _localizedValues[locale.languageCode]!['about']!;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en', 'ar', 'hi', 'ta'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    return AppLocalizations(locale);
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}