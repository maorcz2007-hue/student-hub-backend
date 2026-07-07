import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:student_hub/app/theme/color_schemes.dart';
import 'package:student_hub/app/theme/text_styles.dart';

/// Main theme configuration providing Apple-inspired Material 3 + Cupertino hybrid themes.
class AppTheme {
  AppTheme._();

  // ─── Shared Constants ─────────────────────────────────────
  static const double borderRadius = 14.0;
  static const double borderRadiusLarge = 20.0;
  static const double borderRadiusXL = 28.0;
  static const double cardElevation = 0.0;
  static const Duration animationDuration = Duration(milliseconds: 300);
  static const Curve animationCurve = Curves.easeInOutCubicEmphasized;

  // ─── Light Theme ──────────────────────────────────────────
  static ThemeData lightTheme([Color? seedColor]) {
    final colorScheme = AppColorSchemes.lightScheme(seedColor);
    final textTheme = AppTextStyles.textTheme(Brightness.light);

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: colorScheme,
      textTheme: textTheme,
      scaffoldBackgroundColor: const Color(0xFFF2F2F7),
      fontFamily: 'SF-Pro',

      // ── App Bar ──
      appBarTheme: AppBarTheme(
        elevation: 0,
        scrolledUnderElevation: 0.5,
        centerTitle: true,
        backgroundColor: const Color(0xFFF2F2F7).withValues(alpha: 0.94),
        surfaceTintColor: Colors.transparent,
        titleTextStyle: textTheme.headlineSmall,
        iconTheme: IconThemeData(color: colorScheme.primary, size: 22),
      ),

      // ── Bottom Nav ──
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        elevation: 0,
        backgroundColor: Colors.white.withValues(alpha: 0.94),
        selectedItemColor: colorScheme.primary,
        unselectedItemColor: const Color(0xFF8E8E93),
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: textTheme.labelSmall?.copyWith(fontWeight: FontWeight.w600),
        unselectedLabelStyle: textTheme.labelSmall,
      ),

      // ── Navigation Bar (M3) ──
      navigationBarTheme: NavigationBarThemeData(
        elevation: 0,
        backgroundColor: Colors.white.withValues(alpha: 0.94),
        indicatorColor: colorScheme.primary.withValues(alpha: 0.12),
        labelTextStyle: WidgetStatePropertyAll(
          textTheme.labelSmall?.copyWith(fontWeight: FontWeight.w600),
        ),
        height: 65,
      ),

      // ── Card ──
      cardTheme: CardThemeData(
        elevation: 0,
        color: Colors.white,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      ),

      // ── Input Decoration ──
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: const Color(0xFFE5E5EA).withValues(alpha: 0.50),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: colorScheme.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: colorScheme.error, width: 1.5),
        ),
        hintStyle: textTheme.bodyMedium?.copyWith(
          color: const Color(0xFFC7C7CC),
        ),
        labelStyle: textTheme.bodyMedium,
      ),

      // ── Elevated Button ──
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: colorScheme.primary,
          foregroundColor: Colors.white,
          minimumSize: const Size(double.infinity, 52),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          textStyle: textTheme.titleMedium?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      // ── Text Button ──
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: colorScheme.primary,
          textStyle: textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
        ),
      ),

      // ── Outlined Button ──
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: colorScheme.primary,
          minimumSize: const Size(double.infinity, 52),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          side: BorderSide(color: colorScheme.primary, width: 1.5),
        ),
      ),

      // ── Floating Action Button ──
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        elevation: 4,
        backgroundColor: colorScheme.primary,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
      ),

      // ── Chip ──
      chipTheme: ChipThemeData(
        backgroundColor: const Color(0xFFF2F2F7),
        selectedColor: colorScheme.primary.withValues(alpha: 0.15),
        labelStyle: textTheme.labelMedium,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        side: BorderSide.none,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      ),

      // ── Bottom Sheet ──
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        dragHandleColor: const Color(0xFFC7C7CC),
        dragHandleSize: const Size(36, 5),
        showDragHandle: true,
      ),

      // ── Dialog ──
      dialogTheme: DialogThemeData(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        elevation: 8,
      ),

      // ── Snackbar ──
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: const Color(0xFF1C1C1E),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        contentTextStyle: textTheme.bodyMedium?.copyWith(color: Colors.white),
      ),

      // ── Divider ──
      dividerTheme: const DividerThemeData(
        color: Color(0xFFE5E5EA),
        thickness: 0.5,
        space: 0.5,
      ),

      // ── List Tile ──
      listTileTheme: ListTileThemeData(
        contentPadding: const EdgeInsets.symmetric(horizontal: 20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        titleTextStyle: textTheme.bodyLarge,
        subtitleTextStyle: textTheme.bodySmall,
      ),

      // ── Switch ──
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStatePropertyAll(Colors.white),
        trackColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return colorScheme.primary;
          }
          return const Color(0xFFE5E5EA);
        }),
      ),

      // ── Tab Bar ──
      tabBarTheme: TabBarThemeData(
        indicatorColor: colorScheme.primary,
        labelColor: colorScheme.primary,
        unselectedLabelColor: const Color(0xFF8E8E93),
        indicatorSize: TabBarIndicatorSize.label,
        labelStyle: textTheme.titleSmall,
        unselectedLabelStyle: textTheme.bodySmall,
      ),

      // ── Page Transitions ──
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: {
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          TargetPlatform.macOS: CupertinoPageTransitionsBuilder(),
          TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
          TargetPlatform.windows: FadeUpwardsPageTransitionsBuilder(),
          TargetPlatform.linux: FadeUpwardsPageTransitionsBuilder(),
        },
      ),
    );
  }

  // ─── Dark Theme ──────────────────────────────────────────
  static ThemeData darkTheme([Color? seedColor]) {
    final colorScheme = AppColorSchemes.darkScheme(seedColor);
    final textTheme = AppTextStyles.textTheme(Brightness.dark);

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: colorScheme,
      textTheme: textTheme,
      scaffoldBackgroundColor: const Color(0xFF000000),
      fontFamily: 'SF-Pro',

      // ── App Bar ──
      appBarTheme: AppBarTheme(
        elevation: 0,
        scrolledUnderElevation: 0.5,
        centerTitle: true,
        backgroundColor: const Color(0xFF000000).withValues(alpha: 0.94),
        surfaceTintColor: Colors.transparent,
        titleTextStyle: textTheme.headlineSmall,
        iconTheme: IconThemeData(color: colorScheme.primary, size: 22),
      ),

      // ── Bottom Nav ──
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        elevation: 0,
        backgroundColor: const Color(0xFF1C1C1E).withValues(alpha: 0.94),
        selectedItemColor: colorScheme.primary,
        unselectedItemColor: const Color(0xFF8E8E93),
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: textTheme.labelSmall?.copyWith(fontWeight: FontWeight.w600),
        unselectedLabelStyle: textTheme.labelSmall,
      ),

      // ── Navigation Bar (M3) ──
      navigationBarTheme: NavigationBarThemeData(
        elevation: 0,
        backgroundColor: const Color(0xFF1C1C1E).withValues(alpha: 0.94),
        indicatorColor: colorScheme.primary.withValues(alpha: 0.20),
        labelTextStyle: WidgetStatePropertyAll(
          textTheme.labelSmall?.copyWith(fontWeight: FontWeight.w600),
        ),
        height: 65,
      ),

      // ── Card ──
      cardTheme: CardThemeData(
        elevation: 0,
        color: const Color(0xFF1C1C1E),
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      ),

      // ── Input Decoration ──
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: const Color(0xFF2C2C2E),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: colorScheme.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: colorScheme.error, width: 1.5),
        ),
        hintStyle: textTheme.bodyMedium?.copyWith(
          color: const Color(0xFF48484A),
        ),
        labelStyle: textTheme.bodyMedium,
      ),

      // ── Elevated Button ──
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: colorScheme.primary,
          foregroundColor: Colors.white,
          minimumSize: const Size(double.infinity, 52),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          textStyle: textTheme.titleMedium?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      // ── Text Button ──
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: colorScheme.primary,
          textStyle: textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
        ),
      ),

      // ── Outlined Button ──
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: colorScheme.primary,
          minimumSize: const Size(double.infinity, 52),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          side: BorderSide(color: colorScheme.primary, width: 1.5),
        ),
      ),

      // ── FAB ──
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        elevation: 4,
        backgroundColor: colorScheme.primary,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
      ),

      // ── Chip ──
      chipTheme: ChipThemeData(
        backgroundColor: const Color(0xFF2C2C2E),
        selectedColor: colorScheme.primary.withValues(alpha: 0.25),
        labelStyle: textTheme.labelMedium,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        side: BorderSide.none,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      ),

      // ── Bottom Sheet ──
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: const Color(0xFF1C1C1E),
        surfaceTintColor: Colors.transparent,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        dragHandleColor: const Color(0xFF48484A),
        dragHandleSize: const Size(36, 5),
        showDragHandle: true,
      ),

      // ── Dialog ──
      dialogTheme: DialogThemeData(
        backgroundColor: const Color(0xFF2C2C2E),
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        elevation: 8,
      ),

      // ── Snackbar ──
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: const Color(0xFF2C2C2E),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        contentTextStyle: textTheme.bodyMedium?.copyWith(color: Colors.white),
      ),

      // ── Divider ──
      dividerTheme: const DividerThemeData(
        color: Color(0xFF38383A),
        thickness: 0.5,
        space: 0.5,
      ),

      // ── List Tile ──
      listTileTheme: ListTileThemeData(
        contentPadding: const EdgeInsets.symmetric(horizontal: 20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        titleTextStyle: textTheme.bodyLarge,
        subtitleTextStyle: textTheme.bodySmall,
      ),

      // ── Switch ──
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStatePropertyAll(Colors.white),
        trackColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return colorScheme.primary;
          }
          return const Color(0xFF39393D);
        }),
      ),

      // ── Tab Bar ──
      tabBarTheme: TabBarThemeData(
        indicatorColor: colorScheme.primary,
        labelColor: colorScheme.primary,
        unselectedLabelColor: const Color(0xFF8E8E93),
        indicatorSize: TabBarIndicatorSize.label,
        labelStyle: textTheme.titleSmall,
        unselectedLabelStyle: textTheme.bodySmall,
      ),

      // ── Page Transitions ──
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: {
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          TargetPlatform.macOS: CupertinoPageTransitionsBuilder(),
          TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
          TargetPlatform.windows: FadeUpwardsPageTransitionsBuilder(),
          TargetPlatform.linux: FadeUpwardsPageTransitionsBuilder(),
        },
      ),
    );
  }
}
