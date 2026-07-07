import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:student_hub/core/widgets/glass_card.dart';

class FeedbackScreen extends StatelessWidget {
  const FeedbackScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Feedback')),
      body: ListView(padding: const EdgeInsets.all(16), children: [
        GlassCard(
          onTap: () => context.pushNamed('submit-feedback'),
          padding: const EdgeInsets.all(16),
          child: Row(children: [
            Icon(Icons.bug_report, color: theme.colorScheme.primary, size: 24),
            const SizedBox(width: 14),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('Report a Bug', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
              Text('Help us fix issues', style: theme.textTheme.bodySmall),
            ])),
            Icon(Icons.chevron_right, color: theme.colorScheme.onSurface.withValues(alpha: 0.30)),
          ]),
        ),
        const SizedBox(height: 8),
        GlassCard(
          onTap: () => context.pushNamed('submit-feedback'),
          padding: const EdgeInsets.all(16),
          child: Row(children: [
            Icon(Iconsax.lamp_charge, color: theme.colorScheme.primary, size: 24),
            const SizedBox(width: 14),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('Feature Request', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
              Text('Suggest new features', style: theme.textTheme.bodySmall),
            ])),
            Icon(Icons.chevron_right, color: theme.colorScheme.onSurface.withValues(alpha: 0.30)),
          ]),
        ),
        const SizedBox(height: 8),
        GlassCard(
          onTap: () => context.pushNamed('submit-feedback'),
          padding: const EdgeInsets.all(16),
          child: Row(children: [
            Icon(Iconsax.star, color: theme.colorScheme.primary, size: 24),
            const SizedBox(width: 14),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('Rate the App', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
              Text('Share your experience', style: theme.textTheme.bodySmall),
            ])),
            Icon(Icons.chevron_right, color: theme.colorScheme.onSurface.withValues(alpha: 0.30)),
          ]),
        ),
      ]),
    );
  }
}

class SubmitFeedbackScreen extends StatelessWidget {
  const SubmitFeedbackScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Submit Feedback'),
        actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text('Submit'))]),
      body: SingleChildScrollView(padding: const EdgeInsets.all(20), child: Column(children: [
        DropdownButtonFormField<String>(
          decoration: const InputDecoration(labelText: 'Type'),
          items: ['Bug Report', 'Feature Request', 'Suggestion', 'Other'].map((t) => DropdownMenuItem(value: t, child: Text(t))).toList(),
          onChanged: (v) {},
        ),
        const SizedBox(height: 16),
        TextFormField(decoration: const InputDecoration(labelText: 'Title')),
        const SizedBox(height: 16),
        TextFormField(maxLines: 6, decoration: const InputDecoration(labelText: 'Description', alignLabelWithHint: true)),
        const SizedBox(height: 16),
        Row(children: [
          Text('Rating: ', style: Theme.of(context).textTheme.bodyMedium),
          ...List.generate(5, (i) => IconButton(icon: Icon(i < 4 ? Icons.star : Icons.star_border, color: Colors.amber), onPressed: () {})),
        ]),
      ])),
    );
  }
}
