import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_hub/core/storage/local_storage.dart';
import 'package:student_hub/core/l10n/app_locales.dart';

/// Provides the current app locale.
final localeProvider = StateNotifierProvider<LocaleNotifier, Locale>((ref) {
  return LocaleNotifier();
});

class LocaleNotifier extends StateNotifier<Locale> {
  LocaleNotifier() : super(const Locale('en')) {
    _loadSavedLocale();
  }

  void _loadSavedLocale() {
    final saved = LocalStorage.getString('app_locale');
    if (saved != null && AppLocales.localeNames.containsKey(saved)) {
      state = Locale(saved);
    }
  }

  void setLocale(Locale locale) {
    state = locale;
    LocalStorage.setString('app_locale', locale.languageCode);
  }
}
