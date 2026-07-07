import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_hub/features/grades/presentation/providers/grades_provider.dart';
import 'package:student_hub/app/theme/color_schemes.dart';
import 'package:student_hub/core/widgets/glass_card.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:animate_do/animate_do.dart';

class GradesOverviewScreen extends ConsumerWidget {
  const GradesOverviewScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final gradesAsync = ref.watch(gradesProvider);

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF000000) : const Color(0xFFF2F2F7),
      body: gradesAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
        data: (grades) {
          if (grades.isEmpty) {
            return const Center(child: Text('No grades available.'));
          }

          // Calculate GPA and stuff (simplified for now)
          final totalScore = grades.fold<double>(0, (sum, g) => sum + g.score);
          final avgScore = (totalScore / grades.length).toStringAsFixed(1);
          final totalCredits = grades.fold<int>(0, (sum, g) => sum + (g.course?['credits'] ?? 3) as int);

          return CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverAppBar(
                title: const Text('Grades'),
                pinned: true,
                backgroundColor: isDark ? const Color(0xFF000000).withValues(alpha: 0.94) : const Color(0xFFF2F2F7).withValues(alpha: 0.94),
              ),
              SliverPadding(
                padding: const EdgeInsets.all(16),
                sliver: SliverList(delegate: SliverChildListDelegate([
                  // GPA Cards
                  FadeInUp(child: Row(children: [
                    Expanded(child: _gpaCard(theme, 'Semester GPA', '3.85', AppColorSchemes.primaryBlue)),
                    const SizedBox(width: 12),
                    Expanded(child: _gpaCard(theme, 'Overall GPA', '3.67', AppColorSchemes.primaryGreen)),
                  ])),
                  const SizedBox(height: 12),
                  FadeInUp(delay: const Duration(milliseconds: 100), child: Row(children: [
                    Expanded(child: _gpaCard(theme, 'Credits', '$totalCredits', AppColorSchemes.primaryPurple)),
                    const SizedBox(width: 12),
                    Expanded(child: _gpaCard(theme, 'Avg Grade', '$avgScore%', AppColorSchemes.primaryOrange)),
                  ])),
                  const SizedBox(height: 24),

                  // Course Grades
                  FadeInUp(
                    delay: const Duration(milliseconds: 300),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Course Grades', style: theme.textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w600)),
                        const SizedBox(height: 12),
                        ...grades.map((g) {
                          final courseName = g.course?['name'] ?? 'Unknown Course';
                          final credits = g.course?['credits'] ?? 3;
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: GlassCard(
                              padding: const EdgeInsets.all(14),
                              child: Row(children: [
                                Container(
                                  width: 48, height: 48,
                                  decoration: BoxDecoration(
                                    color: AppColorSchemes.primaryBlue.withValues(alpha: 0.12),
                                    borderRadius: BorderRadius.circular(14),
                                  ),
                                  child: Center(child: Text('${g.score.toInt()}', style: TextStyle(color: AppColorSchemes.primaryBlue, fontWeight: FontWeight.w700, fontSize: 16))),
                                ),
                                const SizedBox(width: 14),
                                Expanded(child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(courseName, style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
                                    Text('$credits credits', style: theme.textTheme.bodySmall),
                                  ],
                                )),
                                Icon(Icons.chevron_right, color: theme.colorScheme.onSurface.withValues(alpha: 0.30)),
                              ]),
                            ),
                          );
                        }),
                      ],
                    ),
                  ),
                  const SizedBox(height: 100),
                ])),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _gpaCard(ThemeData theme, String label, String value, Color color) {
    return GlassCard(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 36, height: 36,
            decoration: BoxDecoration(color: color.withValues(alpha: 0.12), borderRadius: BorderRadius.circular(10)),
            child: Icon(Iconsax.chart_2, color: color, size: 18),
          ),
          const SizedBox(height: 10),
          Text(value, style: theme.textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w800)),
          Text(label, style: theme.textTheme.bodySmall),
        ],
      ),
    );
  }
}

