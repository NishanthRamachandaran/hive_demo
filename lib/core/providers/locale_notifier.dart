import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../constants/locale_constants.dart';

final localeNotifierProvider = StateNotifierProvider<LocaleNotifier, Locale>((ref) {
  return LocaleNotifier();
});

class LocaleNotifier extends StateNotifier<Locale> {
  LocaleNotifier() : super(const Locale(LocaleConstants.defaultLanguage)) {
    _loadLanguage();
  }

  Future<void> _loadLanguage() async {
    final box = await Hive.openBox('settings');
    final savedLang = box.get('languageCode', defaultValue: LocaleConstants.defaultLanguage);
    state = Locale(savedLang);
  }

  Future<void> changeLanguage(String code) async {
    if (!LocaleConstants.supportedLanguageCodes.contains(code)) {
      return;
    }
    
    final box = await Hive.openBox('settings');
    await box.put('languageCode', code);
    state = Locale(code);
  }
}