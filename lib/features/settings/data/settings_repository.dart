import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError('sharedPreferencesProvider must be overridden');
});

final settingsRepositoryProvider = Provider<SettingsRepository>((ref) {
  return SettingsRepository(ref.watch(sharedPreferencesProvider));
});

class SettingsRepository {
  final SharedPreferences _prefs;

  SettingsRepository(this._prefs);

  static const _themeModeKey = 'theme_mode';
  static const _themeColorKey = 'theme_color';
  static const _languageKey = 'language_code';

  // ── Theme Mode ──
  ThemeMode getThemeMode() {
    final value = _prefs.getString(_themeModeKey);
    return ThemeMode.values.firstWhere(
      (e) => e.toString() == value,
      orElse: () => ThemeMode.system,
    );
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    await _prefs.setString(_themeModeKey, mode.toString());
  }

  // ── Theme Color ──
  Color? getThemeColor() {
    final value = _prefs.getInt(_themeColorKey);
    return value != null ? Color(value) : null;
  }

  Future<void> setThemeColor(Color color) async {
    await _prefs.setInt(_themeColorKey, color.value);
  }

  // ── Language ──
  String? getLanguageCode() {
    return _prefs.getString(_languageKey);
  }

  Future<void> setLanguageCode(String code) async {
    await _prefs.setString(_languageKey, code);
  }
}
