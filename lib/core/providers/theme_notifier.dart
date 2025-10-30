
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

final themeNotifierProvider = StateNotifierProvider<ThemeNotifier, bool>((ref) {
  return ThemeNotifier();
});

class ThemeNotifier extends StateNotifier<bool> {
  ThemeNotifier() : super(false) {
    _loadTheme();
  }

  Future<void> _loadTheme() async {
    final box = await Hive.openBox('settings');
    final isDark = box.get('isDarkMode', defaultValue: false);
    state = isDark;
  }

  Future<void> toggleTheme(bool isDark) async {
    final box = await Hive.openBox('settings');
    await box.put('isDarkMode', isDark);
    state = isDark;
  }
}