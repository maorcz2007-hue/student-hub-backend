import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_hub/app/theme/color_schemes.dart';
import 'package:student_hub/core/storage/local_storage.dart';

/// Theme mode provider — persists user choice.
final themeModeProvider = StateNotifierProvider<ThemeModeNotifier, ThemeMode>(
  (ref) => ThemeModeNotifier(),
);

class ThemeModeNotifier extends StateNotifier<ThemeMode> {
  ThemeModeNotifier() : super(_loadThemeMode());

  static ThemeMode _loadThemeMode() {
    final saved = LocalStorage.getString('theme_mode');
    switch (saved) {
      case 'light':
        return ThemeMode.light;
      case 'dark':
        return ThemeMode.dark;
      default:
        return ThemeMode.system;
    }
  }

  void setThemeMode(ThemeMode mode) {
    state = mode;
    LocalStorage.setString('theme_mode', mode.name);
  }

  void toggleTheme() {
    if (state == ThemeMode.dark) {
      setThemeMode(ThemeMode.light);
    } else {
      setThemeMode(ThemeMode.dark);
    }
  }
}

/// Dynamic theme color provider — persists user choice.
final themeColorProvider = StateNotifierProvider<ThemeColorNotifier, Color>(
  (ref) => ThemeColorNotifier(),
);

class ThemeColorNotifier extends StateNotifier<Color> {
  ThemeColorNotifier() : super(_loadColor());

  static Color _loadColor() {
    final saved = LocalStorage.getInt('theme_color');
    if (saved != null) {
      return Color(saved);
    }
    return AppColorSchemes.primaryBlue;
  }

  void setColor(Color color) {
    state = color;
    LocalStorage.setInt('theme_color', color.value);
  }
}
