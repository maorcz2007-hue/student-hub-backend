import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_hub/app/router/app_router.dart';
import 'package:student_hub/app/theme/app_theme.dart';
import 'package:student_hub/app/theme/theme_provider.dart';
import 'package:student_hub/core/l10n/app_localizations.dart';
import 'package:student_hub/core/l10n/app_locales.dart';
import 'package:student_hub/core/l10n/locale_provider.dart';

/// Root widget for the StudentHub application.
/// Configures Material + Cupertino theming, routing, localization, and global providers.
class StudentHubApp extends ConsumerWidget {
  const StudentHubApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);
    final themeColor = ref.watch(themeColorProvider);
    final router = ref.watch(routerProvider);
    final locale = ref.watch(localeProvider);

    return MaterialApp.router(
      title: 'StudentHub',
      debugShowCheckedModeBanner: false,

      // ── Theme ──
      theme: AppTheme.lightTheme(themeColor),
      darkTheme: AppTheme.darkTheme(themeColor),
      themeMode: themeMode,

      // ── Localization ──
      locale: locale,
      supportedLocales: AppLocales.supportedLocales,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],

      // ── Router ──
      routerConfig: router,

      // ── Scroll behavior for smooth scrolling ──
      scrollBehavior: const _AppScrollBehavior(),

      // ── Builder for global overlays ──
      builder: (context, child) {
        return Directionality(
          textDirection: AppLocales.isRtl(locale)
              ? TextDirection.rtl
              : TextDirection.ltr,
          child: MediaQuery(
            data: MediaQuery.of(context).copyWith(
              textScaler: TextScaler.noScaling,
            ),
            child: child ?? const SizedBox.shrink(),
          ),
        );
      },
    );
  }
}

/// Custom scroll behavior for smooth, bouncing scrolls across platforms.
class _AppScrollBehavior extends ScrollBehavior {
  const _AppScrollBehavior();

  @override
  ScrollPhysics getScrollPhysics(BuildContext context) {
    return const BouncingScrollPhysics(
      parent: AlwaysScrollableScrollPhysics(),
    );
  }
}
