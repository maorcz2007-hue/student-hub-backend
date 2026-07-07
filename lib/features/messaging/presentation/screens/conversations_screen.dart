import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:student_hub/core/widgets/glass_card.dart';
import 'package:student_hub/core/widgets/avatar_widget.dart';

class ConversationsScreen extends StatelessWidget {
  const ConversationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final conversations = [
      _Conv('Study Group CS201', 'Alex: Did anyone finish the BST?', DateTime.now().subtract(const Duration(minutes: 5)), 3, true),
      _Conv('Dr. Smith', 'Your assignment has been graded', DateTime.now().subtract(const Duration(hours: 2)), 1, false),
      _Conv('Sarah Johnson', 'Thanks for the notes!', DateTime.now().subtract(const Duration(hours: 5)), 0, false),
      _Conv('Physics Lab Team', 'Meeting tomorrow at 2 PM', DateTime.now().subtract(const Duration(days: 1)), 0, true),
    ];

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF000000) : const Color(0xFFF2F2F7),
      appBar: AppBar(title: const Text('Messages'), backgroundColor: Colors.transparent,
        actions: [IconButton(icon: const Icon(Iconsax.edit), onPressed: () {})],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: conversations.length,
        itemBuilder: (context, index) {
          final c = conversations[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: GlassCard(
              onTap: () => context.pushNamed('chat', pathParameters: {'id': '$index'}),
              padding: const EdgeInsets.all(14),
              child: Row(children: [
                AvatarWidget(name: c.name, size: 48, showOnlineIndicator: true, isOnline: index < 2),
                const SizedBox(width: 14),
                Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Row(children: [
                    if (c.isGroup) Icon(Iconsax.people, size: 14, color: theme.colorScheme.primary),
                    if (c.isGroup) const SizedBox(width: 4),
                    Expanded(child: Text(c.name, style: theme.textTheme.titleMedium?.copyWith(fontWeight: c.unread > 0 ? FontWeight.w700 : FontWeight.w500))),
                    Text(_timeAgo(c.time), style: theme.textTheme.labelSmall),
                  ]),
                  const SizedBox(height: 4),
                  Row(children: [
                    Expanded(child: Text(c.lastMessage, style: theme.textTheme.bodySmall?.copyWith(fontWeight: c.unread > 0 ? FontWeight.w600 : FontWeight.w400), maxLines: 1, overflow: TextOverflow.ellipsis)),
                    if (c.unread > 0)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                        decoration: BoxDecoration(color: theme.colorScheme.primary, borderRadius: BorderRadius.circular(10)),
                        child: Text('${c.unread}', style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w600)),
                      ),
                  ]),
                ])),
              ]),
            ),
          );
        },
      ),
    );
  }

  String _timeAgo(DateTime t) {
    final d = DateTime.now().difference(t);
    if (d.inMinutes < 60) return '${d.inMinutes}m';
    if (d.inHours < 24) return '${d.inHours}h';
    return '${d.inDays}d';
  }
}

class ChatScreen extends StatelessWidget {
  final String conversationId;
  const ChatScreen({super.key, required this.conversationId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Chat')),
      body: Column(children: [
        const Expanded(child: Center(child: Text('Real-time messaging coming soon'))),
        SafeArea(child: Padding(
          padding: const EdgeInsets.all(8),
          child: Row(children: [
            Expanded(child: TextField(decoration: InputDecoration(hintText: 'Message...', border: OutlineInputBorder(borderRadius: BorderRadius.circular(24), borderSide: BorderSide.none), filled: true))),
            const SizedBox(width: 8),
            FloatingActionButton.small(onPressed: () {}, child: const Icon(Icons.send)),
          ]),
        )),
      ]),
    );
  }
}

class _Conv {
  final String name, lastMessage;
  final DateTime time;
  final int unread;
  final bool isGroup;
  _Conv(this.name, this.lastMessage, this.time, this.unread, this.isGroup);
}
