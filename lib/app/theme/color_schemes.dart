import 'package:flutter/material.dart';

/// Apple-inspired color schemes for light and dark modes.
/// Uses HSL-tuned colors for a premium, harmonious look.
class AppColorSchemes {
  AppColorSchemes._();

  // ─── Brand Colors ──────────────────────────────────────────
  static const Color primaryBlue = Color(0xFF007AFF);
  static const Color primaryIndigo = Color(0xFF5856D6);
  static const Color primaryPurple = Color(0xFFAF52DE);
  static const Color primaryPink = Color(0xFFFF2D55);
  static const Color primaryRed = Color(0xFFFF3B30);
  static const Color primaryOrange = Color(0xFFFF9500);
  static const Color primaryYellow = Color(0xFFFFCC00);
  static const Color primaryGreen = Color(0xFF34C759);
  static const Color primaryTeal = Color(0xFF5AC8FA);
  static const Color primaryMint = Color(0xFF00C7BE);

  // ─── Dynamic Color Palette Options ─────────────────────────
  static const List<Color> themeColors = [
    primaryBlue,
    primaryIndigo,
    primaryPurple,
    primaryPink,
    primaryOrange,
    primaryGreen,
    primaryTeal,
    primaryMint,
  ];

  // ─── Light Color Scheme ────────────────────────────────────
  static ColorScheme lightScheme([Color? seedColor]) {
    final seed = seedColor ?? primaryBlue;
    return ColorScheme.fromSeed(
      seedColor: seed,
      brightness: Brightness.light,
      primary: seed,
      onPrimary: Colors.white,
      primaryContainer: seed.withValues(alpha: 0.12),
      onPrimaryContainer: seed,
      secondary: const Color(0xFF8E8E93),
      onSecondary: Colors.white,
      secondaryContainer: const Color(0xFFF2F2F7),
      onSecondaryContainer: const Color(0xFF3C3C43),
      surface: Colors.white,
      onSurface: const Color(0xFF1C1C1E),
      surfaceContainerHighest: const Color(0xFFF2F2F7),
      error: primaryRed,
      onError: Colors.white,
      outline: const Color(0xFFC7C7CC),
      outlineVariant: const Color(0xFFE5E5EA),
      shadow: const Color(0x1A000000),
    );
  }

  // ─── Dark Color Scheme ─────────────────────────────────────
  static ColorScheme darkScheme([Color? seedColor]) {
    final seed = seedColor ?? primaryBlue;
    return ColorScheme.fromSeed(
      seedColor: seed,
      brightness: Brightness.dark,
      primary: seed,
      onPrimary: Colors.white,
      primaryContainer: seed.withValues(alpha: 0.20),
      onPrimaryContainer: seed,
      secondary: const Color(0xFF8E8E93),
      onSecondary: Colors.white,
      secondaryContainer: const Color(0xFF2C2C2E),
      onSecondaryContainer: const Color(0xFFEBEBF5),
      surface: const Color(0xFF1C1C1E),
      onSurface: const Color(0xFFF2F2F7),
      surfaceContainerHighest: const Color(0xFF2C2C2E),
      error: const Color(0xFFFF453A),
      onError: Colors.white,
      outline: const Color(0xFF48484A),
      outlineVariant: const Color(0xFF38383A),
      shadow: const Color(0x40000000),
    );
  }

  // ─── Glassmorphism Colors ──────────────────────────────────
  static Color glassBackground(Brightness brightness) {
    return brightness == Brightness.light
        ? Colors.white.withValues(alpha: 0.72)
        : const Color(0xFF2C2C2E).withValues(alpha: 0.72);
  }

  static Color glassBorder(Brightness brightness) {
    return brightness == Brightness.light
        ? Colors.white.withValues(alpha: 0.40)
        : Colors.white.withValues(alpha: 0.10);
  }

  // ─── Gradient Backgrounds ──────────────────────────────────
  static LinearGradient lightBackgroundGradient([Color? seedColor]) {
    final seed = seedColor ?? primaryBlue;
    return LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        const Color(0xFFF5F5FA),
        seed.withValues(alpha: 0.05),
        const Color(0xFFF5F5FA),
      ],
    );
  }

  static LinearGradient darkBackgroundGradient([Color? seedColor]) {
    final seed = seedColor ?? primaryBlue;
    return LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        const Color(0xFF0A0A0A),
        seed.withValues(alpha: 0.08),
        const Color(0xFF0A0A0A),
      ],
    );
  }

  static LinearGradient primaryGradient([Color? seedColor]) {
    final seed = seedColor ?? primaryBlue;
    return LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        seed,
        Color.lerp(seed, primaryPurple, 0.5)!,
      ],
    );
  }
}
