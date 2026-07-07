import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class AssignmentDetailScreen extends StatelessWidget {
  final String assignmentId;
  const AssignmentDetailScreen({super.key, required this.assignmentId});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Assignment Details')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Data Structures HW3', style: theme.textTheme.displaySmall?.copyWith(fontWeight: FontWeight.w700)),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: const Color(0xFFFF3B30).withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text('High Priority', style: TextStyle(color: Color(0xFFFF3B30), fontWeight: FontWeight.w600, fontSize: 12)),
            ),
            const SizedBox(height: 20),
            _infoRow(theme, Iconsax.book_1, 'Course', 'Data Structures'),
            _infoRow(theme, Iconsax.calendar_1, 'Due Date', 'Tomorrow, 11:59 PM'),
            _infoRow(theme, Iconsax.clock, 'Est. Time', '3 hours'),
            _infoRow(theme, Iconsax.status, 'Status', 'In Progress'),
            const SizedBox(height: 20),
            Text('Description', style: theme.textTheme.headlineSmall),
            const SizedBox(height: 8),
            Text('Implement a Binary Search Tree with insert, delete, search, and traversal operations. Include unit tests.',
              style: theme.textTheme.bodyLarge),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Iconsax.tick_circle),
                    label: const Text('Mark Complete'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoRow(ThemeData theme, IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, size: 20, color: theme.colorScheme.primary),
          const SizedBox(width: 12),
          Text(label, style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurface.withValues(alpha: 0.60))),
          const Spacer(),
          Text(value, style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}
