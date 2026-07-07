import 'package:flutter/material.dart';

/// Supported app locales.
class AppLocales {
  AppLocales._();

  static const Locale english = Locale('en');
  static const Locale hebrew = Locale('he');
  static const Locale arabic = Locale('ar');
  static const Locale russian = Locale('ru');
  static const Locale french = Locale('fr');
  static const Locale spanish = Locale('es');
  static const Locale german = Locale('de');
  static const Locale portuguese = Locale('pt');
  static const Locale chinese = Locale('zh');
  static const Locale japanese = Locale('ja');
  static const Locale korean = Locale('ko');
  static const Locale turkish = Locale('tr');

  static const List<Locale> supportedLocales = [
    english,
    hebrew,
    arabic,
    russian,
    french,
    spanish,
    german,
    portuguese,
    chinese,
    japanese,
    korean,
    turkish,
  ];

  /// Human-readable names for the language picker UI.
  static const Map<String, String> localeNames = {
    'en': 'English',
    'he': 'עברית',
    'ar': 'العربية',
    'ru': 'Русский',
    'fr': 'Français',
    'es': 'Español',
    'de': 'Deutsch',
    'pt': 'Português',
    'zh': '中文',
    'ja': '日本語',
    'ko': '한국어',
    'tr': 'Türkçe',
  };

  /// RTL languages.
  static bool isRtl(Locale locale) {
    return locale.languageCode == 'he' || locale.languageCode == 'ar';
  }
}
