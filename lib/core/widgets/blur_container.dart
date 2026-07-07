import 'dart:ui';
import 'package:flutter/material.dart';

/// A container with a frosted glass / blur effect.
/// More flexible than GlassCard — can be used as a background layer.
class BlurContainer extends StatelessWidget {
  final Widget child;
  final double blur;
  final Color? color;
  final double borderRadius;
  final EdgeInsetsGeometry? padding;

  const BlurContainer({
    super.key,
    required this.child,
    this.blur = 25,
    this.color,
    this.borderRadius = 0,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = color ??
        (isDark
            ? const Color(0xFF1C1C1E).withValues(alpha: 0.80)
            : Colors.white.withValues(alpha: 0.80));

    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
        child: Container(
          padding: padding,
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          child: child,
        ),
      ),
    );
  }
}
