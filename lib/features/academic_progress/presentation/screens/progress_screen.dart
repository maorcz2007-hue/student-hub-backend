import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:student_hub/core/widgets/glass_card.dart';
import 'package:student_hub/app/theme/color_schemes.dart';

class ProgressScreen extends StatelessWidget {
  const ProgressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF000000) : const Color(0xFFF2F2F7),
      appBar: AppBar(title: const Text('Academic Progress'), backgroundColor: Colors.transparent),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          // Graduation Progress
          GlassCard(
            padding: const EdgeInsets.all(20),
            child: Column(children: [
              SizedBox(
                width: 140, height: 140,
                child: Stack(alignment: Alignment.center, children: [
                  SizedBox(width: 140, height: 140, child: CircularProgressIndicator(
                    value: 84 / 120, strokeWidth: 12,
                    backgroundColor: theme.colorScheme.primary.withValues(alpha: 0.12),
                    color: theme.colorScheme.primary, strokeCap: StrokeCap.round,
                  )),
                  Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Text('70%', style: theme.textTheme.displaySmall?.copyWith(fontWeight: FontWeight.w800, color: theme.colorScheme.primary)),
                    Text('Graduation', style: theme.textTheme.labelSmall),
                  ]),
                ]),
              ),
              const SizedBox(height: 16),
              Text('84 of 120 Credits Completed', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
              Text('Estimated graduation: June 2027', style: theme.textTheme.bodySmall),
            ]),
          ),
          const SizedBox(height: 16),

          // Stats Row
          Row(children: [
            Expanded(child: _statCard(theme, '6', 'Active\nCourses', Iconsax.book, AppColorSchemes.primaryBlue)),
            const SizedBox(width: 10),
            Expanded(child: _statCard(theme, '3.67', 'Overall\nGPA', Iconsax.chart_2, AppColorSchemes.primaryGreen)),
            const SizedBox(width: 10),
            Expanded(child: _statCard(theme, '96%', 'Attendance', Iconsax.calendar_tick, AppColorSchemes.primaryPurple)),
          ]),
          const SizedBox(height: 24),

          Text('Achievements', style: theme.textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w600)),
          const SizedBox(height: 12),
          ..._achievements.map((a) => Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: GlassCard(
              padding: const EdgeInsets.all(14),
              child: Row(children: [
                Container(
                  width: 44, height: 44,
                  decoration: BoxDecoration(color: a.color.withValues(alpha: 0.12), borderRadius: BorderRadius.circular(12)),
                  child: Icon(a.icon, color: a.color, size: 22),
                ),
                const SizedBox(width: 14),
                Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(a.title, style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
                  Text(a.description, style: theme.textTheme.bodySmall),
                ])),
              ]),
            ),
          )),
          const SizedBox(height: 40),
        ]),
      ),
    );
  }

  Widget _statCard(ThemeData theme, String value, String label, IconData icon, Color color) {
    return GlassCard(
      padding: const EdgeInsets.all(14),
      child: Column(children: [
        Icon(icon, color: color, size: 24),
        const SizedBox(height: 8),
        Text(value, style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w700)),
        Text(label, style: theme.textTheme.labelSmall, textAlign: TextAlign.center),
      ]),
    );
  }
}

final _achievements = [
  _Achievement("Dean's List", 'GPA above 3.5 for 3 semesters', Iconsax.medal_star, AppColorSchemes.primaryYellow),
  _Achievement('Perfect Attendance', '100% attendance this month', Iconsax.calendar_tick, AppColorSchemes.primaryGreen),
  _Achievement('Early Bird', 'Submitted 10 assignments early', Iconsax.clock, AppColorSchemes.primaryBlue),
  _Achievement('Top Performer', 'Ranked in top 5% of class', Iconsax.crown_1, AppColorSchemes.primaryPurple),
];

class _Achievement {
  final String title, description;
  final IconData icon;
  final Color color;
  _Achievement(this.title, this.description, this.icon, this.color);
}
