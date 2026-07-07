import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:student_hub/core/widgets/glass_card.dart';
import 'package:student_hub/app/theme/color_schemes.dart';
import '../providers/course_provider.dart';

class CoursesListScreen extends ConsumerWidget {
  const CoursesListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final coursesState = ref.watch(courseNotifierProvider);

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF000000) : const Color(0xFFF2F2F7),
      appBar: AppBar(title: const Text('Courses'), backgroundColor: Colors.transparent),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/courses/add'),
        child: const Icon(Icons.add),
      ),
      body: coursesState.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error loading courses: $err')),
        data: (courses) {
          if (courses.isEmpty) {
            return const Center(child: Text('No active courses found. Tap + to add one.'));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: courses.length,
            itemBuilder: (context, index) {
              final c = courses[index];
              // Our API returns: { id, name, code, credits, teacherId, description, status, semester }
              final String name = c['name'] ?? 'Unknown Course';
              final String code = c['code'] ?? 'N/A';
              final int credits = c['credits'] ?? 3;
              
              // Dynamic color based on index
              final colors = [
                AppColorSchemes.primaryBlue,
                AppColorSchemes.primaryPurple,
                AppColorSchemes.primaryGreen,
                AppColorSchemes.primaryOrange,
                AppColorSchemes.primaryTeal,
                AppColorSchemes.primaryPink,
              ];
              final color = colors[index % colors.length];

              return Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: GlassCard(
                  padding: const EdgeInsets.all(16),
                  child: Row(children: [
                    Container(
                      width: 52, height: 52,
                      decoration: BoxDecoration(color: color.withValues(alpha: 0.12), borderRadius: BorderRadius.circular(14)),
                      child: Center(child: Text(code.length >= 2 ? code.substring(0, 2) : code, style: TextStyle(color: color, fontWeight: FontWeight.w700, fontSize: 16))),
                    ),
                    const SizedBox(width: 14),
                    Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Text(name, style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
                      Text('$credits credits', style: theme.textTheme.bodySmall),
                      const SizedBox(height: 6),
                      LinearProgressIndicator(
                        value: 0.5, // Mock progress for now
                        backgroundColor: color.withValues(alpha: 0.10), color: color,
                        borderRadius: BorderRadius.circular(4), minHeight: 4,
                      ),
                    ])),
                    Icon(Icons.chevron_right, color: theme.colorScheme.onSurface.withValues(alpha: 0.30)),
                  ]),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class CourseDetailScreen extends StatelessWidget {
  final String courseId;
  const CourseDetailScreen({super.key, required this.courseId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Course Details')),
      body: const Center(child: Text('Course Detail - Coming soon')),
    );
  }
}
