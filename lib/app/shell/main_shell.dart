import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

/// Main shell widget providing bottom navigation for the core tabs.
/// Uses a frosted glass bottom bar for an Apple-like aesthetic.
class MainShell extends ConsumerStatefulWidget {
  final Widget child;

  const MainShell({super.key, required this.child});

  @override
  ConsumerState<MainShell> createState() => _MainShellState();
}

class _MainShellState extends ConsumerState<MainShell> {
  int _currentIndex = 0;

  static const _tabs = [
    _TabItem(route: '/dashboard', icon: Iconsax.home_2, activeIcon: Iconsax.home_2, label: 'Home'),
    _TabItem(route: '/assignments', icon: Iconsax.task_square, activeIcon: Iconsax.task_square, label: 'Tasks'),
    _TabItem(route: '/grades', icon: Iconsax.chart_2, activeIcon: Iconsax.chart_2, label: 'Grades'),
    _TabItem(route: '/calendar', icon: Iconsax.calendar_1, activeIcon: Iconsax.calendar_1, label: 'Calendar'),
    _TabItem(route: '/profile', icon: Iconsax.user, activeIcon: Iconsax.user, label: 'Profile'),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    // Determine current index from location
    final location = GoRouterState.of(context).matchedLocation;
    for (int i = 0; i < _tabs.length; i++) {
      if (location.startsWith(_tabs[i].route)) {
        _currentIndex = i;
        break;
      }
    }

    return Scaffold(
      body: widget.child,
      extendBody: true,
      bottomNavigationBar: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
          child: Container(
            decoration: BoxDecoration(
              color: isDark
                  ? const Color(0xFF1C1C1E).withValues(alpha: 0.85)
                  : Colors.white.withValues(alpha: 0.85),
              border: Border(
                top: BorderSide(
                  color: isDark
                      ? Colors.white.withValues(alpha: 0.08)
                      : Colors.black.withValues(alpha: 0.06),
                  width: 0.5,
                ),
              ),
            ),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: List.generate(_tabs.length, (index) {
                    final tab = _tabs[index];
                    final isActive = _currentIndex == index;

                    return Expanded(
                      child: GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () {
                          if (_currentIndex != index) {
                            setState(() => _currentIndex = index);
                            context.go(tab.route);
                          }
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          curve: Curves.easeInOut,
                          padding: const EdgeInsets.symmetric(vertical: 6),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              AnimatedSwitcher(
                                duration: const Duration(milliseconds: 200),
                                child: Icon(
                                  isActive ? tab.activeIcon : tab.icon,
                                  key: ValueKey(isActive),
                                  size: 24,
                                  color: isActive
                                      ? theme.colorScheme.primary
                                      : (isDark
                                          ? const Color(0xFF8E8E93)
                                          : const Color(0xFF8E8E93)),
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                tab.label,
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
                                  color: isActive
                                      ? theme.colorScheme.primary
                                      : const Color(0xFF8E8E93),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _TabItem {
  final String route;
  final IconData icon;
  final IconData activeIcon;
  final String label;

  const _TabItem({
    required this.route,
    required this.icon,
    required this.activeIcon,
    required this.label,
  });
}
