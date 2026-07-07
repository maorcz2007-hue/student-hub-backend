import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_hub/core/storage/local_storage.dart';

class SettingsState {
  final bool biometricEnabled;
  final bool appLockEnabled;
  final bool animationsEnabled;
  final bool highContrastEnabled;

  const SettingsState({
    this.biometricEnabled = false,
    this.appLockEnabled = false,
    this.animationsEnabled = true,
    this.highContrastEnabled = false,
  });

  SettingsState copyWith({
    bool? biometricEnabled,
    bool? appLockEnabled,
    bool? animationsEnabled,
    bool? highContrastEnabled,
  }) {
    return SettingsState(
      biometricEnabled: biometricEnabled ?? this.biometricEnabled,
      appLockEnabled: appLockEnabled ?? this.appLockEnabled,
      animationsEnabled: animationsEnabled ?? this.animationsEnabled,
      highContrastEnabled: highContrastEnabled ?? this.highContrastEnabled,
    );
  }
}

final settingsProvider = StateNotifierProvider<SettingsNotifier, SettingsState>((ref) {
  return SettingsNotifier();
});

class SettingsNotifier extends StateNotifier<SettingsState> {
  SettingsNotifier() : super(const SettingsState()) {
    _loadSettings();
  }

  void _loadSettings() {
    state = SettingsState(
      biometricEnabled: LocalStorage.getBool('setting_biometric', defaultValue: false),
      appLockEnabled: LocalStorage.getBool('setting_app_lock', defaultValue: false),
      animationsEnabled: LocalStorage.getBool('setting_animations', defaultValue: true),
      highContrastEnabled: LocalStorage.getBool('setting_high_contrast', defaultValue: false),
    );
  }

  void toggleBiometric(bool value) {
    state = state.copyWith(biometricEnabled: value);
    LocalStorage.setBool('setting_biometric', value);
  }

  void toggleAppLock(bool value) {
    state = state.copyWith(appLockEnabled: value);
    LocalStorage.setBool('setting_app_lock', value);
  }

  void toggleAnimations(bool value) {
    state = state.copyWith(animationsEnabled: value);
    LocalStorage.setBool('setting_animations', value);
  }

  void toggleHighContrast(bool value) {
    state = state.copyWith(highContrastEnabled: value);
    LocalStorage.setBool('setting_high_contrast', value);
  }
}
