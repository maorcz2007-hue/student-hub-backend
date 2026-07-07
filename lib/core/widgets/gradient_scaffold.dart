import 'package:flutter/material.dart';
import 'package:student_hub/app/theme/color_schemes.dart';

/// A scaffold with a beautiful gradient background.
/// Supports both light and dark themes automatically.
class GradientScaffold extends StatelessWidget {
  final Widget body;
  final PreferredSizeWidget? appBar;
  final Widget? bottomNavigationBar;
  final Widget? floatingActionButton;
  final bool extendBody;
  final bool extendBodyBehindAppBar;
  final Color? seedColor;

  const GradientScaffold({
    super.key,
    required this.body,
    this.appBar,
    this.bottomNavigationBar,
    this.floatingActionButton,
    this.extendBody = false,
    this.extendBodyBehindAppBar = true,
    this.seedColor,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final color = seedColor ?? Theme.of(context).colorScheme.primary;

    return Container(
      decoration: BoxDecoration(
        gradient: isDark
            ? AppColorSchemes.darkBackgroundGradient(color)
            : AppColorSchemes.lightBackgroundGradient(color),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: appBar,
        body: body,
        bottomNavigationBar: bottomNavigationBar,
        floatingActionButton: floatingActionButton,
        extendBody: extendBody,
        extendBodyBehindAppBar: extendBodyBehindAppBar,
      ),
    );
  }
}
