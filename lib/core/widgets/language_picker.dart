import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_hub/core/l10n/app_locales.dart';
import 'package:student_hub/core/l10n/locale_provider.dart';

class LanguagePicker extends ConsumerWidget {
  const LanguagePicker({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentLocale = ref.watch(localeProvider);
    final theme = Theme.of(context);

    return PopupMenuButton<Locale>(
      initialValue: currentLocale,
      icon: Icon(Icons.language, color: theme.colorScheme.onSurface.withValues(alpha: 0.7)),
      onSelected: (Locale locale) {
        ref.read(localeProvider.notifier).setLocale(locale);
      },
      itemBuilder: (BuildContext context) {
        return AppLocales.supportedLocales.map((Locale locale) {
          final isSelected = locale == currentLocale;
          return PopupMenuItem<Locale>(
            value: locale,
            child: Row(
              children: [
                Text(
                  AppLocales.localeNames[locale.languageCode] ?? locale.languageCode,
                  style: TextStyle(
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                    color: isSelected ? theme.colorScheme.primary : theme.colorScheme.onSurface,
                  ),
                ),
                if (isSelected) ...[
                  const Spacer(),
                  Icon(Icons.check, size: 18, color: theme.colorScheme.primary),
                ],
              ],
            ),
          );
        }).toList();
      },
    );
  }
}
