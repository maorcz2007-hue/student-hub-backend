import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:animate_do/animate_do.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:student_hub/app/theme/color_schemes.dart';
import 'package:student_hub/core/utils/date_formatter.dart';
import 'package:student_hub/core/widgets/glass_card.dart';
import 'package:student_hub/core/widgets/avatar_widget.dart';
import 'package:student_hub/core/widgets/stats_card.dart';
import 'package:student_hub/features/auth/presentation/providers/auth_provider.dart';
import 'package:student_hub/features/dashboard/presentation/providers/dashboard_provider.dart';
import 'package:student_hub/features/dashboard/domain/models/dashboard_data.dart';

/// Beautiful dashboard screen with welcome message, GPA, schedule, and stats.
class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authStateProvider).user;
    final dashboardState = ref.watch(dashboardNotifierProvider);
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF000000) : const Color(0xFFF2F2F7),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // ── App Bar ──
          SliverAppBar(
            expandedHeight: 120,
            floating: false,
            pinned: true,
            backgroundColor: isDark
                ? const Color(0xFF000000).withValues(alpha: 0.94)
                : const Color(0xFFF2F2F7).withValues(alpha: 0.94),
            surfaceTintColor: Colors.transparent,
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: const EdgeInsets.only(left: 20, bottom: 14),
              title: Text(
                DateFormatter.greeting(),
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              background: Container(
                padding: const EdgeInsets.fromLTRB(20, 60, 20, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Notifications
                    GestureDetector(
                      onTap: () => context.pushNamed('notifications'),
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: isDark
                              ? Colors.white.withValues(alpha: 0.08)
                              : Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Stack(
                          children: [
                            Center(child: Icon(Iconsax.notification, size: 20, color: theme.colorScheme.onSurface)),
                            Positioned(
                              right: 8,
                              top: 8,
                              child: Container(
                                width: 8,
                                height: 8,
                                decoration: const BoxDecoration(
                                  color: Color(0xFFFF3B30),
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    AvatarWidget(
                      name: user?.fullName ?? 'User',
                      size: 40,
                      onTap: () => context.pushNamed('profile'),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // ── Content ──
          dashboardState.when(
            loading: () => const SliverFillRemaining(
              child: Center(child: CircularProgressIndicator()),
            ),
            error: (err, stack) => SliverFillRemaining(
              child: Center(child: Text('Error loading dashboard: $err')),
            ),
            data: (data) {
              if (data == null) {
                return const SliverFillRemaining(
                  child: Center(child: Text('No dashboard data available.')),
                );
              }

              return SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    const SizedBox(height: 8),

                    // Welcome name
                    FadeInLeft(
                      duration: const Duration(milliseconds: 400),
                      child: Text(
                        user?.fullName ?? 'Student',
                        style: theme.textTheme.displaySmall?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    FadeInLeft(
                      duration: const Duration(milliseconds: 400),
                      delay: const Duration(milliseconds: 100),
                      child: Text(
                        '${user?.university ?? 'University'} • ${user?.department ?? 'Department'}',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.onSurface.withValues(alpha: 0.60),
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),

                    // ── GPA Card ──
                    FadeInUp(
                      duration: const Duration(milliseconds: 500),
                      child: _buildGPACard(context, theme, isDark, data),
                    ),

                    const SizedBox(height: 16),

                    // ── Quick Actions ──
                    FadeInUp(
                      duration: const Duration(milliseconds: 500),
                      delay: const Duration(milliseconds: 100),
                      child: _buildQuickActions(context, theme, isDark),
                    ),

                    const SizedBox(height: 24),

                    // ── Statistics Grid ──
                    FadeInUp(
                      duration: const Duration(milliseconds: 500),
                      delay: const Duration(milliseconds: 200),
                      child: _buildStatsGrid(theme, data),
                    ),

                    const SizedBox(height: 24),

                    // ── Today's Schedule ──
                    FadeInUp(
                      duration: const Duration(milliseconds: 500),
                      delay: const Duration(milliseconds: 300),
                      child: _buildScheduleSection(context, theme, isDark, data),
                    ),

                    const SizedBox(height: 24),

                    // ── Upcoming Deadlines ──
                    FadeInUp(
                      duration: const Duration(milliseconds: 500),
                      delay: const Duration(milliseconds: 400),
                      child: _buildDeadlinesSection(context, theme, isDark, data),
                    ),

                    const SizedBox(height: 24),

                    // ── Grade Chart ──
                    FadeInUp(
                      duration: const Duration(milliseconds: 500),
                      delay: const Duration(milliseconds: 500),
                      child: _buildGradeChart(context, theme, isDark, data),
                    ),

                    const SizedBox(height: 24),

                    // ── AI Suggestion ──
                    FadeInUp(
                      duration: const Duration(milliseconds: 500),
                      delay: const Duration(milliseconds: 600),
                      child: _buildAISuggestion(context, theme, isDark, data),
                    ),

                    // Bottom padding for nav bar
                    const SizedBox(height: 100),
                  ]),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildGPACard(BuildContext context, ThemeData theme, bool isDark, DashboardData data) {
    return GlassCard(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          // GPA Circle
          SizedBox(
            width: 100,
            height: 100,
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 100,
                  height: 100,
                  child: CircularProgressIndicator(
                    value: data.gpa / 4.0,
                    strokeWidth: 8,
                    backgroundColor: theme.colorScheme.primary.withValues(alpha: 0.12),
                    color: theme.colorScheme.primary,
                    strokeCap: StrokeCap.round,
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      data.gpa.toStringAsFixed(2),
                      style: theme.textTheme.displaySmall?.copyWith(
                        fontWeight: FontWeight.w800,
                        color: theme.colorScheme.primary,
                      ),
                    ),
                    Text(
                      'GPA',
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: theme.colorScheme.onSurface.withValues(alpha: 0.50),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Academic Standing',
                  style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 4),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFF34C759).withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    data.academicStanding,
                    style: const TextStyle(
                      color: Color(0xFF34C759),
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                _buildProgressRow('Completed', data.completedCredits, data.totalCredits, theme),
                const SizedBox(height: 6),
                _buildProgressRow('This Semester', data.semesterCreditsCompleted, data.semesterCreditsTotal, theme),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressRow(String label, int current, int total, ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: theme.textTheme.labelSmall),
            Text('$current/$total', style: theme.textTheme.labelSmall?.copyWith(fontWeight: FontWeight.w600)),
          ],
        ),
        const SizedBox(height: 4),
        LinearProgressIndicator(
          value: total > 0 ? current / total : 0,
          backgroundColor: theme.colorScheme.primary.withValues(alpha: 0.10),
          color: theme.colorScheme.primary,
          borderRadius: BorderRadius.circular(4),
          minHeight: 4,
        ),
      ],
    );
  }

  Widget _buildQuickActions(BuildContext context, ThemeData theme, bool isDark) {
    final actions = [
      _QuickAction(Iconsax.message, 'AI Chat', AppColorSchemes.primaryPurple, () => context.pushNamed('ai-assistant')),
      _QuickAction(Iconsax.calendar_1, 'Calendar', AppColorSchemes.primaryOrange, () => context.pushNamed('calendar')),
      _QuickAction(Iconsax.book_1, 'Courses', AppColorSchemes.primaryGreen, () => context.pushNamed('courses')),
      _QuickAction(Iconsax.document_text, 'Files', AppColorSchemes.primaryTeal, () => context.pushNamed('file-manager')),
    ];

    return SizedBox(
      height: 90,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: actions.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final action = actions[index];
          return GestureDetector(
            onTap: action.onTap,
            child: Container(
              width: 78,
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: isDark
                    ? Colors.white.withValues(alpha: 0.06)
                    : Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: isDark
                    ? null
                    : [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.04),
                          blurRadius: 10,
                          offset: const Offset(0, 2),
                        ),
                      ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: action.color.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(action.icon, color: action.color, size: 20),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    action.label,
                    style: theme.textTheme.labelSmall?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildStatsGrid(ThemeData theme, DashboardData data) {
    return GridView.count(
      crossAxisCount: 2,
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      childAspectRatio: 1.4,
      children: [
        StatsCard(
          icon: Iconsax.task_square,
          value: data.pendingTasks.toString(),
          label: 'Pending Tasks',
          iconColor: AppColorSchemes.primaryOrange,
        ),
        StatsCard(
          icon: Iconsax.medal_star,
          value: '${data.avgGrade.toStringAsFixed(1)}%',
          label: 'Avg. Grade',
          iconColor: AppColorSchemes.primaryGreen,
        ),
        StatsCard(
          icon: Iconsax.book,
          value: data.activeCourses.toString(),
          label: 'Active Courses',
          iconColor: AppColorSchemes.primaryBlue,
        ),
        StatsCard(
          icon: Iconsax.clock,
          value: '${data.studyTimeHours}h',
          label: 'Study Time',
          iconColor: AppColorSchemes.primaryPurple,
        ),
      ],
    );
  }

  Widget _buildScheduleSection(BuildContext context, ThemeData theme, bool isDark, DashboardData data) {
    if (data.todaySchedule.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Today's Schedule", style: theme.textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w600)),
            TextButton(
              onPressed: () => context.pushNamed('calendar'),
              child: const Text('See All'),
            ),
          ],
        ),
        const SizedBox(height: 8),
        ...data.todaySchedule.map((item) => Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: GlassCard(
            padding: const EdgeInsets.all(14),
            child: Row(
              children: [
                Container(
                  width: 4,
                  height: 48,
                  decoration: BoxDecoration(
                    color: Color(item.colorValue),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(item.name, style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
                      const SizedBox(height: 2),
                      Row(
                        children: [
                          Icon(Iconsax.clock, size: 14, color: theme.colorScheme.onSurface.withValues(alpha: 0.50)),
                          const SizedBox(width: 4),
                          Text(item.time, style: theme.textTheme.bodySmall),
                          const SizedBox(width: 12),
                          Icon(Iconsax.location, size: 14, color: theme.colorScheme.onSurface.withValues(alpha: 0.50)),
                          const SizedBox(width: 4),
                          Text(item.location, style: theme.textTheme.bodySmall),
                        ],
                      ),
                    ],
                  ),
                ),
                if (item.isNow)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFF34C759).withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text('Now', style: TextStyle(color: Color(0xFF34C759), fontWeight: FontWeight.w600, fontSize: 12)),
                  ),
              ],
            ),
          ),
        )),
      ],
    );
  }

  Widget _buildDeadlinesSection(BuildContext context, ThemeData theme, bool isDark, DashboardData data) {
    if (data.upcomingDeadlines.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Upcoming Deadlines', style: theme.textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w600)),
            TextButton(
              onPressed: () => context.go('/assignments'),
              child: const Text('See All'),
            ),
          ],
        ),
        const SizedBox(height: 8),
        ...data.upcomingDeadlines.map((d) => Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: GlassCard(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(d.title, style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
                    Text(d.due, style: TextStyle(color: Color(d.colorValue), fontSize: 12, fontWeight: FontWeight.w600)),
                  ],
                ),
                const SizedBox(height: 10),
                LinearProgressIndicator(
                  value: d.progress,
                  backgroundColor: Color(d.colorValue).withValues(alpha: 0.12),
                  color: Color(d.colorValue),
                  borderRadius: BorderRadius.circular(4),
                  minHeight: 6,
                ),
                const SizedBox(height: 4),
                Text('${(d.progress * 100).toInt()}% complete', style: theme.textTheme.labelSmall),
              ],
            ),
          ),
        )),
      ],
    );
  }

  Widget _buildGradeChart(BuildContext context, ThemeData theme, bool isDark, DashboardData data) {
    if (data.gradeTrend.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Grade Trend', style: theme.textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w600)),
        const SizedBox(height: 12),
        GlassCard(
          padding: const EdgeInsets.all(16),
          child: SizedBox(
            height: 200,
            child: LineChart(
              LineChartData(
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: false,
                  horizontalInterval: 1,
                  getDrawingHorizontalLine: (value) => FlLine(
                    color: theme.colorScheme.outline.withValues(alpha: 0.10),
                    strokeWidth: 1,
                  ),
                ),
                titlesData: FlTitlesData(
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 32,
                      interval: 1,
                      getTitlesWidget: (value, meta) {
                        return Text(
                          value.toInt().toString(),
                          style: theme.textTheme.labelSmall,
                        );
                      },
                    ),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        const months = ['Sep', 'Oct', 'Nov', 'Dec', 'Jan', 'Feb'];
                        if (value.toInt() < months.length) {
                          return Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Text(months[value.toInt()], style: theme.textTheme.labelSmall),
                          );
                        }
                        return const SizedBox.shrink();
                      },
                    ),
                  ),
                  rightTitles: const AxisTitles(),
                  topTitles: const AxisTitles(),
                ),
                borderData: FlBorderData(show: false),
                minX: 0,
                maxX: 5,
                minY: 80,
                maxY: 100,
                lineBarsData: [
                  LineChartBarData(
                    spots: data.gradeTrend.map((t) => FlSpot(t.monthIndex, t.score)).toList(),
                    isCurved: true,
                    color: theme.colorScheme.primary,
                    barWidth: 3,
                    isStrokeCapRound: true,
                    dotData: FlDotData(
                      show: true,
                      getDotPainter: (spot, percent, barData, index) {
                        return FlDotCirclePainter(
                          radius: 4,
                          color: theme.colorScheme.primary,
                          strokeWidth: 2,
                          strokeColor: Colors.white,
                        );
                      },
                    ),
                    belowBarData: BarAreaData(
                      show: true,
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          theme.colorScheme.primary.withValues(alpha: 0.25),
                          theme.colorScheme.primary.withValues(alpha: 0.02),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAISuggestion(BuildContext context, ThemeData theme, bool isDark, DashboardData data) {
    if (data.aiSuggestion.isEmpty) return const SizedBox.shrink();

    return GlassCard(
      padding: const EdgeInsets.all(16),
      onTap: () => context.pushNamed('ai-assistant'),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColorSchemes.primaryPurple, AppColorSchemes.primaryBlue],
              ),
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Icon(Iconsax.magic_star, color: Colors.white, size: 24),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('AI Study Suggestion', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
                const SizedBox(height: 2),
                Text(
                  data.aiSuggestion,
                  style: theme.textTheme.bodySmall,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          Icon(Icons.chevron_right, color: theme.colorScheme.onSurface.withValues(alpha: 0.40)),
        ],
      ),
    );
  }
}

class _QuickAction {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  _QuickAction(this.icon, this.label, this.color, this.onTap);
}
