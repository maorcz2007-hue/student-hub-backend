import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Apple-inspired typography system using Inter (closest to SF Pro on non-Apple platforms).
class AppTextStyles {
  AppTextStyles._();

  static const String _fontFamily = 'SF-Pro';

  /// Get the text theme for the app, using Google Fonts Inter as fallback.
  static TextTheme textTheme(Brightness brightness) {
    final baseColor = brightness == Brightness.light
        ? const Color(0xFF1C1C1E)
        : const Color(0xFFF2F2F7);

    final secondaryColor = brightness == Brightness.light
        ? const Color(0xFF8E8E93)
        : const Color(0xFF98989D);

    return TextTheme(
      // ── Display ──
      displayLarge: _style(
        fontSize: 34,
        fontWeight: FontWeight.w700,
        color: baseColor,
        height: 1.21,
        letterSpacing: 0.37,
      ),
      displayMedium: _style(
        fontSize: 28,
        fontWeight: FontWeight.w700,
        color: baseColor,
        height: 1.21,
        letterSpacing: 0.36,
      ),
      displaySmall: _style(
        fontSize: 24,
        fontWeight: FontWeight.w700,
        color: baseColor,
        height: 1.25,
        letterSpacing: 0.35,
      ),

      // ── Headline ──
      headlineLarge: _style(
        fontSize: 22,
        fontWeight: FontWeight.w600,
        color: baseColor,
        height: 1.27,
        letterSpacing: 0.35,
      ),
      headlineMedium: _style(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: baseColor,
        height: 1.25,
      ),
      headlineSmall: _style(
        fontSize: 17,
        fontWeight: FontWeight.w600,
        color: baseColor,
        height: 1.29,
        letterSpacing: -0.41,
      ),

      // ── Title ──
      titleLarge: _style(
        fontSize: 17,
        fontWeight: FontWeight.w600,
        color: baseColor,
        height: 1.29,
        letterSpacing: -0.41,
      ),
      titleMedium: _style(
        fontSize: 15,
        fontWeight: FontWeight.w600,
        color: baseColor,
        height: 1.33,
        letterSpacing: -0.24,
      ),
      titleSmall: _style(
        fontSize: 13,
        fontWeight: FontWeight.w600,
        color: baseColor,
        height: 1.38,
        letterSpacing: -0.08,
      ),

      // ── Body ──
      bodyLarge: _style(
        fontSize: 17,
        fontWeight: FontWeight.w400,
        color: baseColor,
        height: 1.29,
        letterSpacing: -0.41,
      ),
      bodyMedium: _style(
        fontSize: 15,
        fontWeight: FontWeight.w400,
        color: baseColor,
        height: 1.33,
        letterSpacing: -0.24,
      ),
      bodySmall: _style(
        fontSize: 13,
        fontWeight: FontWeight.w400,
        color: secondaryColor,
        height: 1.38,
        letterSpacing: -0.08,
      ),

      // ── Label ──
      labelLarge: _style(
        fontSize: 15,
        fontWeight: FontWeight.w500,
        color: baseColor,
        height: 1.33,
        letterSpacing: -0.24,
      ),
      labelMedium: _style(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: secondaryColor,
        height: 1.33,
      ),
      labelSmall: _style(
        fontSize: 11,
        fontWeight: FontWeight.w500,
        color: secondaryColor,
        height: 1.45,
        letterSpacing: 0.06,
      ),
    );
  }

  static TextStyle _style({
    required double fontSize,
    required FontWeight fontWeight,
    required Color color,
    double? height,
    double? letterSpacing,
  }) {
    // Try SF-Pro first, fallback to Google Fonts Inter
    try {
      return TextStyle(
        fontFamily: _fontFamily,
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
        height: height,
        letterSpacing: letterSpacing,
      );
    } catch (_) {
      return GoogleFonts.inter(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
        height: height,
        letterSpacing: letterSpacing,
      );
    }
  }

  /// Convenience method to get Inter font as fallback
  static TextStyle inter({
    double? fontSize,
    FontWeight? fontWeight,
    Color? color,
    double? height,
    double? letterSpacing,
  }) {
    return GoogleFonts.inter(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      height: height,
      letterSpacing: letterSpacing,
    );
  }
}
