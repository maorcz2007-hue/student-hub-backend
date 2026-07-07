import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:student_hub/app/theme/color_schemes.dart';

/// Cupertino theme overrides for iOS-native feeling widgets.
class AppCupertinoTheme {
  AppCupertinoTheme._();

  static CupertinoThemeData lightTheme([Color? seedColor]) {
    final primary = seedColor ?? AppColorSchemes.primaryBlue;
    return CupertinoThemeData(
      brightness: Brightness.light,
      primaryColor: primary,
      primaryContrastingColor: Colors.white,
      scaffoldBackgroundColor: const Color(0xFFF2F2F7),
      barBackgroundColor: const Color(0xFFF2F2F7).withValues(alpha: 0.94),
      textTheme: CupertinoTextThemeData(
        primaryColor: primary,
        textStyle: const TextStyle(
          fontFamily: 'SF-Pro',
          fontSize: 17,
          color: Color(0xFF1C1C1E),
          letterSpacing: -0.41,
        ),
        navTitleTextStyle: TextStyle(
          fontFamily: 'SF-Pro',
          fontSize: 17,
          fontWeight: FontWeight.w600,
          color: const Color(0xFF1C1C1E),
          letterSpacing: -0.41,
        ),
        navLargeTitleTextStyle: const TextStyle(
          fontFamily: 'SF-Pro',
          fontSize: 34,
          fontWeight: FontWeight.w700,
          color: Color(0xFF1C1C1E),
          letterSpacing: 0.37,
        ),
        tabLabelTextStyle: const TextStyle(
          fontFamily: 'SF-Pro',
          fontSize: 10,
          fontWeight: FontWeight.w500,
        ),
        actionTextStyle: TextStyle(
          fontFamily: 'SF-Pro',
          fontSize: 17,
          color: primary,
          letterSpacing: -0.41,
        ),
      ),
    );
  }

  static CupertinoThemeData darkTheme([Color? seedColor]) {
    final primary = seedColor ?? AppColorSchemes.primaryBlue;
    return CupertinoThemeData(
      brightness: Brightness.dark,
      primaryColor: primary,
      primaryContrastingColor: Colors.white,
      scaffoldBackgroundColor: const Color(0xFF000000),
      barBackgroundColor: const Color(0xFF1C1C1E).withValues(alpha: 0.94),
      textTheme: CupertinoTextThemeData(
        primaryColor: primary,
        textStyle: const TextStyle(
          fontFamily: 'SF-Pro',
          fontSize: 17,
          color: Color(0xFFF2F2F7),
          letterSpacing: -0.41,
        ),
        navTitleTextStyle: const TextStyle(
          fontFamily: 'SF-Pro',
          fontSize: 17,
          fontWeight: FontWeight.w600,
          color: Color(0xFFF2F2F7),
          letterSpacing: -0.41,
        ),
        navLargeTitleTextStyle: const TextStyle(
          fontFamily: 'SF-Pro',
          fontSize: 34,
          fontWeight: FontWeight.w700,
          color: Color(0xFFF2F2F7),
          letterSpacing: 0.37,
        ),
        tabLabelTextStyle: const TextStyle(
          fontFamily: 'SF-Pro',
          fontSize: 10,
          fontWeight: FontWeight.w500,
        ),
        actionTextStyle: TextStyle(
          fontFamily: 'SF-Pro',
          fontSize: 17,
          color: primary,
          letterSpacing: -0.41,
        ),
      ),
    );
  }
}
