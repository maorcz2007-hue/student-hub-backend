import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

/// Profile avatar widget with image caching and fallback initials.
class AvatarWidget extends StatelessWidget {
  final String? imageUrl;
  final String name;
  final double size;
  final VoidCallback? onTap;
  final Color? borderColor;
  final double borderWidth;
  final bool showOnlineIndicator;
  final bool isOnline;

  const AvatarWidget({
    super.key,
    this.imageUrl,
    required this.name,
    this.size = 48,
    this.onTap,
    this.borderColor,
    this.borderWidth = 2,
    this.showOnlineIndicator = false,
    this.isOnline = false,
  });

  String get _initials {
    final parts = name.trim().split(' ');
    if (parts.length >= 2) {
      return '${parts.first[0]}${parts.last[0]}'.toUpperCase();
    }
    return name.isNotEmpty ? name[0].toUpperCase() : '?';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    Widget avatar = Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: borderColor != null
            ? Border.all(color: borderColor!, width: borderWidth)
            : null,
        gradient: imageUrl == null
            ? LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  theme.colorScheme.primary,
                  theme.colorScheme.primary.withValues(alpha: 0.70),
                ],
              )
            : null,
      ),
      child: imageUrl != null
          ? ClipOval(
              child: CachedNetworkImage(
                imageUrl: imageUrl!,
                width: size,
                height: size,
                fit: BoxFit.cover,
                placeholder: (_, __) => _buildInitials(theme),
                errorWidget: (_, __, ___) => _buildInitials(theme),
              ),
            )
          : _buildInitials(theme),
    );

    if (showOnlineIndicator) {
      avatar = Stack(
        children: [
          avatar,
          Positioned(
            right: 0,
            bottom: 0,
            child: Container(
              width: size * 0.28,
              height: size * 0.28,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isOnline ? const Color(0xFF34C759) : const Color(0xFF8E8E93),
                border: Border.all(
                  color: theme.scaffoldBackgroundColor,
                  width: 2,
                ),
              ),
            ),
          ),
        ],
      );
    }

    if (onTap != null) {
      return GestureDetector(onTap: onTap, child: avatar);
    }

    return avatar;
  }

  Widget _buildInitials(ThemeData theme) {
    return Center(
      child: Text(
        _initials,
        style: TextStyle(
          color: Colors.white,
          fontSize: size * 0.36,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
