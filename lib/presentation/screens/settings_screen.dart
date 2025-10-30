import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter_example/localization/app_localization.dart';
import 'package:hive_flutter_example/core/providers/locale_notifier.dart';
import 'package:hive_flutter_example/core/providers/theme_notifier.dart';
import 'package:hive_flutter_example/core/constants/locale_constants.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = ref.watch(localeNotifierProvider);
    final localeNotifier = ref.read(localeNotifierProvider.notifier);
    final isDarkMode = ref.watch(themeNotifierProvider); // This is now a boolean
    final themeNotifier = ref.read(themeNotifierProvider.notifier);
    final loc = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(loc.settings),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.language),
            title: Text(loc.language),
            subtitle: Text(_getLanguageName(locale.languageCode)),
            trailing: DropdownButton<String>(
              value: locale.languageCode,
              items: LocaleConstants.supportedLanguages
                  .map((lang) => DropdownMenuItem(
                        value: lang['code'],
                        child: Text(lang['name']!),
                      ))
                  .toList(),
              onChanged: (code) {
                if (code != null) localeNotifier.changeLanguage(code);
              },
            ),
          ),
          ListTile(
            leading: const Icon(Icons.color_lens),
            title: Text(loc.theme),
            subtitle: Text(loc.darkMode),
            trailing: Switch(
              value: isDarkMode, 
              onChanged: (value) {
                themeNotifier.toggleTheme(value);
              },
            ),
          ),
          ListTile(
            leading: const Icon(Icons.backup),
            title: const Text('Backup & Restore'),
            subtitle: const Text('Export and import your data'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.info),
            title: Text(loc.about),
            onTap: () {},
          ),
        ],
      ),
    );
  }

  String _getLanguageName(String code) {
    final lang = LocaleConstants.supportedLanguages
        .firstWhere((element) => element['code'] == code, orElse: () => {'name': 'English'});
    return lang['name']!;
  }
}