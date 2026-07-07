import 'package:flutter/material.dart';
import 'package:student_hub/core/widgets/glass_card.dart';

/// A beautiful statistics card with icon, value, label, and optional trend indicator.
class StatsCard extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;
  final Color? iconColor;
  final Color? iconBackgroundColor;
  final double? trend; // positive = up, negative = down, null = no trend
  final VoidCallback? onTap;

  const StatsCard({
    super.key,
    required this.icon,
    required this.value,
    required this.label,
    this.iconColor,
    this.iconBackgroundColor,
    this.trend,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = iconColor ?? theme.colorScheme.primary;
    final bgColor = iconBackgroundColor ?? color.withValues(alpha: 0.12);

    return GlassCard(
      onTap: onTap,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: bgColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: color, size: 22),
              ),
              if (trend != null)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: (trend! >= 0 ? const Color(0xFF34C759) : const Color(0xFFFF3B30))
                        .withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        trend! >= 0 ? Icons.trending_up : Icons.trending_down,
                        size: 14,
                        color: trend! >= 0 ? const Color(0xFF34C759) : const Color(0xFFFF3B30),
                      ),
                      const SizedBox(width: 2),
                      Text(
                        '${trend!.abs().toStringAsFixed(1)}%',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: trend! >= 0 ? const Color(0xFF34C759) : const Color(0xFFFF3B30),
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            value,
            style: theme.textTheme.displaySmall?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurface.withValues(alpha: 0.60),
            ),
          ),
        ],
      ),
    );
  }
}
