import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:student_hub/core/widgets/glass_card.dart';
import 'package:student_hub/core/widgets/stats_card.dart';
import 'package:student_hub/app/theme/color_schemes.dart';

class AdminDashboardScreen extends StatelessWidget {
  const AdminDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF000000) : const Color(0xFFF2F2F7),
      appBar: AppBar(title: const Text('Admin Panel'), backgroundColor: Colors.transparent),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          // Stats Grid
          GridView.count(crossAxisCount: 2, mainAxisSpacing: 12, crossAxisSpacing: 12, shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(), childAspectRatio: 1.4, children: [
            StatsCard(icon: Iconsax.people, value: '1,234', label: 'Total Users', iconColor: AppColorSchemes.primaryBlue),
            StatsCard(icon: Iconsax.book, value: '48', label: 'Active Courses', iconColor: AppColorSchemes.primaryGreen),
            StatsCard(icon: Iconsax.task_square, value: '326', label: 'Assignments', iconColor: AppColorSchemes.primaryOrange),
            StatsCard(icon: Iconsax.chart_2, value: '98%', label: 'System Health', iconColor: AppColorSchemes.primaryPurple, trend: 2.1),
          ]),
          const SizedBox(height: 24),

          Text('User Registrations', style: theme.textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w600)),
          const SizedBox(height: 12),
          GlassCard(padding: const EdgeInsets.all(16), child: SizedBox(height: 180,
            child: LineChart(LineChartData(
              gridData: const FlGridData(show: false),
              titlesData: const FlTitlesData(show: false),
              borderData: FlBorderData(show: false),
              lineBarsData: [LineChartBarData(
                spots: const [FlSpot(0, 20), FlSpot(1, 35), FlSpot(2, 28), FlSpot(3, 45), FlSpot(4, 52), FlSpot(5, 61)],
                isCurved: true, color: theme.colorScheme.primary, barWidth: 3, dotData: const FlDotData(show: false),
                belowBarData: BarAreaData(show: true, gradient: LinearGradient(
                  begin: Alignment.topCenter, end: Alignment.bottomCenter,
                  colors: [theme.colorScheme.primary.withValues(alpha: 0.20), theme.colorScheme.primary.withValues(alpha: 0.02)],
                )),
              )],
            )),
          )),
          const SizedBox(height: 24),

          Text('Quick Actions', style: theme.textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w600)),
          const SizedBox(height: 12),
          ...[
            _AdminAction(Iconsax.people, 'Manage Users', 'View, edit, suspend accounts'),
            _AdminAction(Iconsax.book, 'Manage Courses', 'Add, edit, remove courses'),
            _AdminAction(Iconsax.notification, 'Announcements', 'Send announcements'),
            _AdminAction(Iconsax.document_text, 'Activity Logs', 'View system activity'),
            _AdminAction(Iconsax.chart_1, 'Analytics', 'View detailed analytics'),
          ].map((a) => Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: GlassCard(
              onTap: () {},
              padding: const EdgeInsets.all(14),
              child: Row(children: [
                Container(width: 44, height: 44, decoration: BoxDecoration(color: theme.colorScheme.primary.withValues(alpha: 0.12), borderRadius: BorderRadius.circular(12)),
                  child: Icon(a.icon, color: theme.colorScheme.primary, size: 22)),
                const SizedBox(width: 14),
                Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(a.title, style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
                  Text(a.subtitle, style: theme.textTheme.bodySmall),
                ])),
                Icon(Icons.chevron_right, color: theme.colorScheme.onSurface.withValues(alpha: 0.30)),
              ]),
            ),
          )),
          const SizedBox(height: 40),
        ]),
      ),
    );
  }
}

class _AdminAction { final IconData icon; final String title, subtitle; _AdminAction(this.icon, this.title, this.subtitle); }
