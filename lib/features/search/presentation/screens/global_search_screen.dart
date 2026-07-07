import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:student_hub/core/widgets/glass_card.dart';

class GlobalSearchScreen extends StatefulWidget {
  const GlobalSearchScreen({super.key});

  @override
  State<GlobalSearchScreen> createState() => _GlobalSearchScreenState();
}

class _GlobalSearchScreenState extends State<GlobalSearchScreen> {
  final _controller = TextEditingController();
  String _query = '';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF000000) : const Color(0xFFF2F2F7),
      appBar: AppBar(
        title: TextField(
          controller: _controller,
          autofocus: true,
          decoration: InputDecoration(hintText: 'Search everything...', border: InputBorder.none,
            prefixIcon: const Icon(Iconsax.search_normal, size: 20)),
          onChanged: (v) => setState(() => _query = v),
        ),
        backgroundColor: Colors.transparent,
      ),
      body: _query.isEmpty
          ? _buildRecent(theme)
          : _buildResults(theme),
    );
  }

  Widget _buildRecent(ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('Recent Searches', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
        const SizedBox(height: 12),
        Wrap(spacing: 8, runSpacing: 8, children: ['Data Structures', 'Linear Algebra', 'Physics Lab', 'AI Project']
            .map((s) => ActionChip(label: Text(s), onPressed: () => setState(() { _controller.text = s; _query = s; }))).toList()),
        const SizedBox(height: 24),
        Text('Categories', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
        const SizedBox(height: 12),
        ...[
          _SearchCategory(Iconsax.task_square, 'Assignments', '23 items'),
          _SearchCategory(Iconsax.book, 'Courses', '6 items'),
          _SearchCategory(Iconsax.message, 'Messages', '142 items'),
          _SearchCategory(Iconsax.chart_2, 'Grades', '34 items'),
          _SearchCategory(Iconsax.document, 'Files', '67 items'),
        ].map((c) => ListTile(
          leading: Icon(c.icon, color: theme.colorScheme.primary),
          title: Text(c.label),
          trailing: Text(c.count, style: theme.textTheme.bodySmall),
        )),
      ]),
    );
  }

  Widget _buildResults(ThemeData theme) {
    return ListView(padding: const EdgeInsets.all(16), children: [
      Text('Results for "$_query"', style: theme.textTheme.titleMedium),
      const SizedBox(height: 12),
      ...[1, 2, 3].map((_) => Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: GlassCard(
          padding: const EdgeInsets.all(14),
          child: Row(children: [
            Icon(Iconsax.task_square, color: theme.colorScheme.primary),
            const SizedBox(width: 14),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('Result matching "$_query"', style: theme.textTheme.titleMedium),
              Text('Assignment • Data Structures', style: theme.textTheme.bodySmall),
            ])),
          ]),
        ),
      )),
    ]);
  }
}

class _SearchCategory { final IconData icon; final String label, count; _SearchCategory(this.icon, this.label, this.count); }
