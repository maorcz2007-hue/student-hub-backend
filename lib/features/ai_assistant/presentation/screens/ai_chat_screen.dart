import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:student_hub/app/theme/color_schemes.dart';

class AiChatScreen extends StatefulWidget {
  const AiChatScreen({super.key});

  @override
  State<AiChatScreen> createState() => _AiChatScreenState();
}

class _AiChatScreenState extends State<AiChatScreen> {
  final _controller = TextEditingController();
  final _scrollController = ScrollController();
  final _messages = <_ChatMessage>[
    _ChatMessage('Hello! I\'m your AI study assistant. How can I help you today?', false, DateTime.now().subtract(const Duration(minutes: 5))),
  ];
  bool _isTyping = false;

  void _sendMessage() {
    if (_controller.text.trim().isEmpty) return;
    setState(() {
      _messages.add(_ChatMessage(_controller.text.trim(), true, DateTime.now()));
      _isTyping = true;
    });
    _controller.clear();

    // Simulate AI response
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          _messages.add(_ChatMessage(
            'That\'s a great question! Let me help you with that. Based on your current coursework, I\'d recommend focusing on the Binary Search Tree implementation for your Data Structures assignment.',
            false,
            DateTime.now(),
          ));
          _isTyping = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF000000) : const Color(0xFFF2F2F7),
      appBar: AppBar(
        title: Row(children: [
          Container(
            width: 32, height: 32,
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [AppColorSchemes.primaryPurple, AppColorSchemes.primaryBlue]),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Iconsax.magic_star, color: Colors.white, size: 16),
          ),
          const SizedBox(width: 10),
          const Text('AI Assistant'),
        ]),
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(icon: const Icon(Iconsax.setting_2), onPressed: () {}),
        ],
      ),
      body: Column(children: [
        // Suggestion chips
        SizedBox(
          height: 40,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            children: ['Explain BST', 'Study plan', 'Quiz me', 'Summarize notes']
                .map((s) => Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: ActionChip(
                    label: Text(s, style: const TextStyle(fontSize: 12)),
                    onPressed: () { _controller.text = s; _sendMessage(); },
                  ),
                ))
                .toList(),
          ),
        ),
        const SizedBox(height: 8),

        // Messages
        Expanded(
          child: ListView.builder(
            controller: _scrollController,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: _messages.length + (_isTyping ? 1 : 0),
            itemBuilder: (context, index) {
              if (index == _messages.length) {
                return _buildTypingIndicator(theme, isDark);
              }
              final msg = _messages[index];
              return _buildMessage(theme, isDark, msg);
            },
          ),
        ),

        // Input
        ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
            child: Container(
              padding: EdgeInsets.fromLTRB(16, 8, 8, MediaQuery.of(context).padding.bottom + 8),
              decoration: BoxDecoration(
                color: isDark ? const Color(0xFF1C1C1E).withValues(alpha: 0.90) : Colors.white.withValues(alpha: 0.90),
                border: Border(top: BorderSide(color: theme.colorScheme.outline.withValues(alpha: 0.15))),
              ),
              child: Row(children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'Ask anything...',
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(24), borderSide: BorderSide.none),
                      filled: true,
                      fillColor: isDark ? const Color(0xFF2C2C2E) : const Color(0xFFF2F2F7),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    ),
                    onSubmitted: (_) => _sendMessage(),
                    textInputAction: TextInputAction.send,
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  width: 44, height: 44,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [AppColorSchemes.primaryPurple, AppColorSchemes.primaryBlue]),
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.arrow_upward, color: Colors.white, size: 20),
                    onPressed: _sendMessage,
                  ),
                ),
              ]),
            ),
          ),
        ),
      ]),
    );
  }

  Widget _buildMessage(ThemeData theme, bool isDark, _ChatMessage msg) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: msg.isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!msg.isUser) ...[
            Container(
              width: 28, height: 28,
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [AppColorSchemes.primaryPurple, AppColorSchemes.primaryBlue]),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Iconsax.magic_star, color: Colors.white, size: 14),
            ),
            const SizedBox(width: 8),
          ],
          Flexible(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: BoxDecoration(
                color: msg.isUser
                    ? theme.colorScheme.primary
                    : (isDark ? const Color(0xFF2C2C2E) : Colors.white),
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(16),
                  topRight: const Radius.circular(16),
                  bottomLeft: Radius.circular(msg.isUser ? 16 : 4),
                  bottomRight: Radius.circular(msg.isUser ? 4 : 16),
                ),
                boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 8)],
              ),
              child: Text(
                msg.content,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: msg.isUser ? Colors.white : theme.colorScheme.onSurface,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTypingIndicator(ThemeData theme, bool isDark) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(children: [
        Container(
          width: 28, height: 28,
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [AppColorSchemes.primaryPurple, AppColorSchemes.primaryBlue]),
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Icon(Iconsax.magic_star, color: Colors.white, size: 14),
        ),
        const SizedBox(width: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF2C2C2E) : Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(mainAxisSize: MainAxisSize.min, children: [
            _dot(0), const SizedBox(width: 4), _dot(1), const SizedBox(width: 4), _dot(2),
          ]),
        ),
      ]),
    );
  }

  Widget _dot(int index) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: Duration(milliseconds: 600 + index * 200),
      builder: (_, v, child) => Opacity(opacity: 0.3 + 0.7 * v, child: child),
      child: Container(width: 6, height: 6, decoration: BoxDecoration(color: Colors.grey, shape: BoxShape.circle)),
    );
  }
}

class _ChatMessage {
  final String content;
  final bool isUser;
  final DateTime timestamp;
  _ChatMessage(this.content, this.isUser, this.timestamp);
}
