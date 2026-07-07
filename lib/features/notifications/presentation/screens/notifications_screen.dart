import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:student_hub/core/widgets/glass_card.dart';
import 'package:student_hub/app/theme/color_schemes.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final notifications = [
      _Notif('New Grade Posted', 'Data Structures HW2: A (96%)', Iconsax.medal_star, AppColorSchemes.primaryGreen, DateTime.now().subtract(const Duration(minutes: 30)), false),
      _Notif('Assignment Due', 'Data Structures HW3 is due tomorrow', Iconsax.timer_1, AppColorSchemes.primaryRed, DateTime.now().subtract(const Duration(hours: 2)), false),
      _Notif('New Message', 'Dr. Smith sent you a message', Iconsax.message, AppColorSchemes.primaryBlue, DateTime.now().subtract(const Duration(hours: 5)), true),
      _Notif('Announcement', 'Campus closed on Friday for holiday', Iconsax.info_circle, AppColorSchemes.primaryOrange, DateTime.now().subtract(const Duration(days: 1)), true),
      _Notif('AI Suggestion', 'Start studying for Linear Algebra exam', Iconsax.magic_star, AppColorSchemes.primaryPurple, DateTime.now().subtract(const Duration(days: 1)), true),
    ];

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF000000) : const Color(0xFFF2F2F7),
      appBar: AppBar(title: const Text('Notifications'), backgroundColor: Colors.transparent,
        actions: [TextButton(onPressed: () {}, child: const Text('Mark all read'))],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          final n = notifications[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: GlassCard(
              padding: const EdgeInsets.all(14),
              opacity: n.isRead ? 0.50 : 0.72,
              child: Row(children: [
                Container(width: 44, height: 44, decoration: BoxDecoration(color: n.color.withValues(alpha: 0.12), borderRadius: BorderRadius.circular(12)),
                  child: Icon(n.icon, color: n.color, size: 22)),
                const SizedBox(width: 14),
                Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(n.title, style: theme.textTheme.titleMedium?.copyWith(fontWeight: n.isRead ? FontWeight.w500 : FontWeight.w600)),
                  Text(n.body, style: theme.textTheme.bodySmall, maxLines: 1, overflow: TextOverflow.ellipsis),
                ])),
                if (!n.isRead) Container(width: 8, height: 8, decoration: BoxDecoration(color: theme.colorScheme.primary, shape: BoxShape.circle)),
              ]),
            ),
          );
        },
      ),
    );
  }
}

class _Notif { final String title, body; final IconData icon; final Color color; final DateTime time; final bool isRead;
  _Notif(this.title, this.body, this.icon, this.color, this.time, this.isRead); }
