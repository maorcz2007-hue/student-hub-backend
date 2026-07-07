import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:animate_do/animate_do.dart';
import 'package:student_hub/core/widgets/glass_card.dart';
import 'package:student_hub/app/theme/color_schemes.dart';
import '../providers/assignments_provider.dart';
import '../../domain/models/assignment.dart';

/// Assignments list screen with filtering, sorting, and search.
class AssignmentsListScreen extends ConsumerStatefulWidget {
  const AssignmentsListScreen({super.key});

  @override
  ConsumerState<AssignmentsListScreen> createState() => _AssignmentsListScreenState();
}

class _AssignmentsListScreenState extends ConsumerState<AssignmentsListScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final _searchController = TextEditingController();

  final _categories = ['All', 'Homework', 'Projects', 'Labs', 'Exams', 'Personal'];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _categories.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    
    final assignmentsState = ref.watch(assignmentsNotifierProvider);

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF000000) : const Color(0xFFF2F2F7),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            title: const Text('Assignments'),
            floating: true,
            pinned: true,
            backgroundColor: isDark
                ? const Color(0xFF000000).withValues(alpha: 0.94)
                : const Color(0xFFF2F2F7).withValues(alpha: 0.94),
            actions: [
              IconButton(
                icon: const Icon(Iconsax.search_normal),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Iconsax.filter),
                onPressed: () {},
              ),
            ],
            bottom: TabBar(
              controller: _tabController,
              isScrollable: true,
              tabs: _categories.map((c) => Tab(text: c)).toList(),
              tabAlignment: TabAlignment.start,
            ),
          ),
          
          assignmentsState.when(
            data: (assignments) {
              if (assignments.isEmpty) {
                return const SliverFillRemaining(
                  child: Center(child: Text('No assignments found.')),
                );
              }
              return SliverPadding(
                padding: const EdgeInsets.all(16),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final assignment = assignments[index];
                      return FadeInUp(
                        duration: const Duration(milliseconds: 300),
                        delay: Duration(milliseconds: index * 50),
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: _buildAssignmentCard(context, theme, isDark, assignment),
                        ),
                      );
                    },
                    childCount: assignments.length,
                  ),
                ),
              );
            },
            loading: () => const SliverFillRemaining(
              child: Center(child: CircularProgressIndicator()),
            ),
            error: (error, stack) => SliverFillRemaining(
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.error_outline, color: Colors.red, size: 48),
                    const SizedBox(height: 16),
                    Text('Failed to load assignments:\n$error', textAlign: TextAlign.center),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () => ref.invalidate(assignmentsNotifierProvider),
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              ),
            ),
          ),
          
          const SliverPadding(padding: EdgeInsets.only(bottom: 100)),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.pushNamed('create-assignment'),
        child: const Icon(Iconsax.add),
      ),
    );
  }

  Widget _buildAssignmentCard(BuildContext context, ThemeData theme, bool isDark, Assignment a) {
    final priorityColor = switch (a.priority) {
      'high' => AppColorSchemes.primaryRed,
      'medium' => AppColorSchemes.primaryOrange,
      _ => AppColorSchemes.primaryGreen,
    };

    return GlassCard(
      onTap: () => context.pushNamed('assignment-detail', pathParameters: {'id': a.id}),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 6,
                height: 6,
                decoration: BoxDecoration(color: priorityColor, shape: BoxShape.circle),
              ),
              const SizedBox(width: 8),
              Text(a.course, style: TextStyle(color: priorityColor, fontSize: 12, fontWeight: FontWeight.w600)),
              const Spacer(),
              if (a.completed)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: AppColorSchemes.primaryGreen.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Text('Completed', style: TextStyle(color: Color(0xFF34C759), fontSize: 11, fontWeight: FontWeight.w600)),
                )
              else
                Text(
                  _dueText(a.dueDate),
                  style: TextStyle(
                    color: a.dueDate.isBefore(DateTime.now()) ? AppColorSchemes.primaryRed : theme.colorScheme.onSurface.withValues(alpha: 0.50),
                    fontSize: 12,
                  ),
                ),
            ],
          ),
          const SizedBox(height: 8),
          Text(a.title, style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
          const SizedBox(height: 4),
          Text(a.description, style: theme.textTheme.bodySmall, maxLines: 1, overflow: TextOverflow.ellipsis),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: LinearProgressIndicator(
                  value: a.progress,
                  backgroundColor: theme.colorScheme.primary.withValues(alpha: 0.10),
                  color: a.completed ? const Color(0xFF34C759) : theme.colorScheme.primary,
                  borderRadius: BorderRadius.circular(4),
                  minHeight: 4,
                ),
              ),
              const SizedBox(width: 10),
              Text('${(a.progress * 100).toInt()}%', style: theme.textTheme.labelSmall?.copyWith(fontWeight: FontWeight.w600)),
            ],
          ),
        ],
      ),
    );
  }

  String _dueText(DateTime date) {
    final diff = date.difference(DateTime.now());
    if (diff.isNegative) return 'Overdue';
    if (diff.inHours < 24) return 'Due in ${diff.inHours}h';
    return 'Due in ${diff.inDays}d';
  }
}
