import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

final localeNotifierProvider = StateNotifierProvider<LocaleNotifier, Locale>((ref) {
  return LocaleNotifier();
});

class LocaleNotifier extends StateNotifier<Locale> {
  LocaleNotifier() : super(const Locale('en')) {
    _loadLanguage();
  }

  Future<void> _loadLanguage() async {
    final box = await Hive.openBox('settings');
    final savedLang = box.get('languageCode', defaultValue: 'en');
    state = Locale(savedLang);
  }

  Future<void> changeLanguage(String code) async {
    final box = await Hive.openBox('settings');
    await box.put('languageCode', code);
    state = Locale(code);
  }
}
