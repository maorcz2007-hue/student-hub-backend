import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:student_hub/app/theme/color_schemes.dart';
import 'package:student_hub/app/theme/theme_provider.dart';
import 'package:student_hub/core/widgets/glass_card.dart';
import 'package:student_hub/features/settings/presentation/providers/settings_provider.dart';

import 'package:go_router/go_router.dart';
import 'package:student_hub/core/l10n/app_locales.dart';
import 'package:student_hub/core/l10n/locale_provider.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final themeMode = ref.watch(themeModeProvider);
    final locale = ref.watch(localeProvider);
    final settings = ref.watch(settingsProvider);
    final settingsNotifier = ref.read(settingsProvider.notifier);

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF000000) : const Color(0xFFF2F2F7),
      appBar: AppBar(title: const Text('Settings'), backgroundColor: Colors.transparent),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _section(theme, 'General', [
            _settingsTile(theme, Iconsax.brush_1, 'Appearance', 
              subtitle: themeMode.name.substring(0, 1).toUpperCase() + themeMode.name.substring(1), 
              onTap: () => context.pushNamed('appearance')),
            _settingsTile(theme, Iconsax.language_circle, 'Language', 
              subtitle: AppLocales.localeNames[locale.languageCode] ?? 'English', 
              onTap: () => _showLanguageDialog(context, ref)),
            _settingsTile(theme, Iconsax.notification, 'Notifications', onTap: () {}),
          ]),
          const SizedBox(height: 16),
          _section(theme, 'Privacy & Security', [
            _settingsTile(theme, Iconsax.shield_tick, 'Privacy', onTap: () {}),
            _settingsTile(theme, Iconsax.lock, 'Security', onTap: () {}),
            _settingsTile(theme, Iconsax.finger_scan, 'Biometric Login', 
              trailing: Switch(value: settings.biometricEnabled, onChanged: settingsNotifier.toggleBiometric)),
            _settingsTile(theme, Iconsax.lock_1, 'App Lock', 
              trailing: Switch(value: settings.appLockEnabled, onChanged: settingsNotifier.toggleAppLock)),
          ]),
          const SizedBox(height: 16),
          _section(theme, 'Accessibility', [
            _settingsTile(theme, Iconsax.text, 'Font Size', subtitle: 'Medium', onTap: () {}),
            _settingsTile(theme, Iconsax.flash_1, 'Animations', 
              trailing: Switch(value: settings.animationsEnabled, onChanged: settingsNotifier.toggleAnimations)),
            _settingsTile(theme, Iconsax.eye, 'High Contrast', 
              trailing: Switch(value: settings.highContrastEnabled, onChanged: settingsNotifier.toggleHighContrast)),
          ]),
          const SizedBox(height: 16),
          _section(theme, 'Integrations', [
            _settingsTile(theme, Iconsax.calendar_1, 'Moodle Calendar Sync', subtitle: 'Import academic events', onTap: () {
              _showMoodleSyncDialog(context, ref);
            }),
          ]),
          const SizedBox(height: 16),
          _section(theme, 'About', [
            _settingsTile(theme, Iconsax.info_circle, 'Version', subtitle: '1.0.0', onTap: () {}),
            _settingsTile(theme, Iconsax.document_text, 'Terms of Service', onTap: () {}),
            _settingsTile(theme, Iconsax.shield_search, 'Privacy Policy', onTap: () {}),
          ]),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _section(ThemeData theme, String title, List<Widget> children) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(title, style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600, color: theme.colorScheme.onSurface.withValues(alpha: 0.60))),
      const SizedBox(height: 8),
      GlassCard(padding: const EdgeInsets.symmetric(vertical: 4), child: Column(children: children)),
    ]);
  }

  Widget _settingsTile(ThemeData theme, IconData icon, String title, {String? subtitle, VoidCallback? onTap, Widget? trailing}) {
    return ListTile(
      leading: Icon(icon, size: 20, color: theme.colorScheme.primary),
      title: Text(title),
      subtitle: subtitle != null ? Text(subtitle, style: theme.textTheme.bodySmall) : null,
      trailing: trailing ?? const Icon(Icons.chevron_right, size: 18),
      onTap: onTap,
    );
  }

  void _showLanguageDialog(BuildContext context, WidgetRef ref) {
    // ... [existing logic omitted for brevity, keeping original content intact]
    showModalBottomSheet(
      context: context,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) {
        return ListView(
          padding: const EdgeInsets.symmetric(vertical: 20),
          shrinkWrap: true,
          children: AppLocales.supportedLocales.map((loc) {
            final isCurrent = ref.read(localeProvider) == loc;
            return ListTile(
              leading: Icon(Icons.language, color: isCurrent ? Theme.of(context).colorScheme.primary : null),
              title: Text(AppLocales.localeNames[loc.languageCode] ?? loc.languageCode),
              trailing: isCurrent ? Icon(Icons.check, color: Theme.of(context).colorScheme.primary) : null,
              onTap: () {
                ref.read(localeProvider.notifier).setLocale(loc);
                Navigator.pop(context);
              },
            );
          }).toList(),
        );
      },
    );
  }

  void _showMoodleSyncDialog(BuildContext context, WidgetRef ref) {
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Moodle Calendar Sync'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Paste your Moodle iCal export URL here to sync assignments and exams to your dashboard.'),
              const SizedBox(height: 16),
              TextField(
                controller: controller,
                decoration: const InputDecoration(
                  labelText: 'iCal URL',
                  hintText: 'https://moodle.youruni.edu/calendar/export...',
                ),
              ),
            ],
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
            ElevatedButton(
              onPressed: () async {
                // Here you would typically call your provider to hit the PUT /api/calendar/moodle endpoint
                // ref.read(calendarProvider.notifier).saveMoodleUrl(controller.text);
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Moodle URL saved! Syncing...')));
                Navigator.pop(context);
              },
              child: const Text('Save & Sync'),
            ),
          ],
        );
      },
    );
  }
}

class AppearanceScreen extends ConsumerWidget {
  const AppearanceScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final themeMode = ref.watch(themeModeProvider);
    final themeColor = ref.watch(themeColorProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Appearance')),
      body: ListView(padding: const EdgeInsets.all(16), children: [
        Text('Theme Mode', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
        const SizedBox(height: 8),
        GlassCard(padding: const EdgeInsets.all(8), child: Column(children: [
          RadioListTile<ThemeMode>(title: const Text('System'), value: ThemeMode.system, groupValue: themeMode,
            onChanged: (v) => ref.read(themeModeProvider.notifier).setThemeMode(v!)),
          RadioListTile<ThemeMode>(title: const Text('Light'), value: ThemeMode.light, groupValue: themeMode,
            onChanged: (v) => ref.read(themeModeProvider.notifier).setThemeMode(v!)),
          RadioListTile<ThemeMode>(title: const Text('Dark'), value: ThemeMode.dark, groupValue: themeMode,
            onChanged: (v) => ref.read(themeModeProvider.notifier).setThemeMode(v!)),
        ])),
        const SizedBox(height: 24),
        Text('Accent Color', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
        const SizedBox(height: 12),
        Wrap(spacing: 12, runSpacing: 12, children: AppColorSchemes.themeColors.map((c) =>
          GestureDetector(
            onTap: () => ref.read(themeColorProvider.notifier).setColor(c),
            child: Container(
              width: 44, height: 44,
              decoration: BoxDecoration(shape: BoxShape.circle, color: c,
                border: Border.all(color: themeColor == c ? Colors.white : Colors.transparent, width: 3),
                boxShadow: [if (themeColor == c) BoxShadow(color: c.withValues(alpha: 0.50), blurRadius: 12)]),
            ),
          ),
        ).toList()),
      ]),
    );
  }
}
