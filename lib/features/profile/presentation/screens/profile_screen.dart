import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:student_hub/core/widgets/avatar_widget.dart';
import 'package:student_hub/core/widgets/glass_card.dart';
import 'package:student_hub/features/auth/presentation/providers/auth_provider.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authStateProvider).user;
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF000000) : const Color(0xFFF2F2F7),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(expandedHeight: 200, pinned: true, backgroundColor: Colors.transparent,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight,
                    colors: [theme.colorScheme.primary, theme.colorScheme.primary.withValues(alpha: 0.70)]),
                ),
                child: SafeArea(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                  const SizedBox(height: 30),
                  AvatarWidget(name: user?.fullName ?? 'User', size: 80, borderColor: Colors.white, borderWidth: 3),
                  const SizedBox(height: 12),
                  Text(user?.fullName ?? 'Student', style: theme.textTheme.headlineMedium?.copyWith(color: Colors.white, fontWeight: FontWeight.w700)),
                  Text(user?.email ?? '', style: theme.textTheme.bodyMedium?.copyWith(color: Colors.white70)),
                ])),
              ),
            ),
            actions: [IconButton(icon: const Icon(Iconsax.edit, color: Colors.white), onPressed: () => context.pushNamed('edit-profile'))],
          ),
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverList(delegate: SliverChildListDelegate([
              _infoSection(theme, 'Student Information', [
                _InfoItem(Iconsax.card, 'Student ID', user?.studentId ?? 'STU-2025-001'),
                _InfoItem(Iconsax.building, 'University', user?.university ?? 'MIT'),
                _InfoItem(Iconsax.book_1, 'Department', user?.department ?? 'Computer Science'),
                _InfoItem(Iconsax.calendar_1, 'Year', '${user?.year ?? 3}'),
              ]),
              const SizedBox(height: 16),
              _menuSection(context, theme, isDark, 'Quick Actions', [
                if (user?.email == 'maorcz2000@gmail.com')
                  _MenuItem(Iconsax.security, 'Admin Panel', () => context.pushNamed('admin-dashboard')),
                _MenuItem(Iconsax.chart_2, 'Academic Progress', () => context.pushNamed('academic-progress')),
                _MenuItem(Iconsax.message, 'Messages', () => context.pushNamed('messaging')),
                _MenuItem(Iconsax.document, 'Files', () => context.pushNamed('file-manager')),
                _MenuItem(Iconsax.star, 'Achievements', () {}),
              ]),
              const SizedBox(height: 16),
              _menuSection(context, theme, isDark, 'Settings', [
                _MenuItem(Iconsax.setting_2, 'Settings', () => context.pushNamed('settings')),
                _MenuItem(Iconsax.brush_1, 'Appearance', () => context.pushNamed('appearance')),
                _MenuItem(Iconsax.message_question, 'Feedback', () => context.pushNamed('feedback')),
                _MenuItem(Iconsax.info_circle, 'About', () {}),
              ]),
              const SizedBox(height: 16),
              GlassCard(
                onTap: () => ref.read(authStateProvider.notifier).logout(),
                padding: const EdgeInsets.all(14),
                child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  const Icon(Iconsax.logout, color: Color(0xFFFF3B30), size: 20),
                  const SizedBox(width: 8),
                  Text('Sign Out', style: TextStyle(color: const Color(0xFFFF3B30), fontWeight: FontWeight.w600)),
                ]),
              ),
              const SizedBox(height: 100),
            ])),
          ),
        ],
      ),
    );
  }

  Widget _infoSection(ThemeData theme, String title, List<_InfoItem> items) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(title, style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600, color: theme.colorScheme.onSurface.withValues(alpha: 0.60))),
      const SizedBox(height: 8),
      GlassCard(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Column(children: items.map((item) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          child: Row(children: [
            Icon(item.icon, size: 20, color: theme.colorScheme.primary),
            const SizedBox(width: 14),
            Text(item.label, style: theme.textTheme.bodyMedium),
            const Spacer(),
            Text(item.value, style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600)),
          ]),
        )).toList()),
      ),
    ]);
  }

  Widget _menuSection(BuildContext context, ThemeData theme, bool isDark, String title, List<_MenuItem> items) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(title, style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600, color: theme.colorScheme.onSurface.withValues(alpha: 0.60))),
      const SizedBox(height: 8),
      GlassCard(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Column(children: items.map((item) => ListTile(
          leading: Icon(item.icon, size: 20, color: theme.colorScheme.primary),
          title: Text(item.label),
          trailing: const Icon(Icons.chevron_right, size: 18),
          onTap: item.onTap,
        )).toList()),
      ),
    ]);
  }
}

class EditProfileScreen extends ConsumerStatefulWidget {
  const EditProfileScreen({super.key});

  @override
  ConsumerState<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends ConsumerState<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _bioController;
  late TextEditingController _universityController;
  late TextEditingController _departmentController;

  @override
  void initState() {
    super.initState();
    final user = ref.read(authStateProvider).user;
    _nameController = TextEditingController(text: user?.fullName ?? '');
    _emailController = TextEditingController(text: user?.email ?? '');
    _bioController = TextEditingController(text: user?.bio ?? '');
    _universityController = TextEditingController(text: user?.university ?? '');
    _departmentController = TextEditingController(text: user?.department ?? '');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _bioController.dispose();
    _universityController.dispose();
    _departmentController.dispose();
    super.dispose();
  }

  Future<void> _handleSave() async {
    if (!_formKey.currentState!.validate()) return;
    
    final success = await ref.read(authNotifierProvider.notifier).updateProfile({
      'fullName': _nameController.text.trim(),
      'email': _emailController.text.trim(),
      'bio': _bioController.text.trim(),
      'university': _universityController.text.trim(),
      'department': _departmentController.text.trim(),
    });

    if (success && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profile updated successfully')),
      );
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authStateProvider);
    final user = authState.user;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
        actions: [
          TextButton(
            onPressed: authState.isLoading ? null : _handleSave,
            child: authState.isLoading 
                ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2)) 
                : const Text('Save'),
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Material(
          type: MaterialType.transparency,
          child: Form(
            key: _formKey,
            child: Column(children: [
            AvatarWidget(name: user?.fullName ?? 'User', size: 100),
            TextButton(onPressed: () {}, child: const Text('Change Photo')),
            const SizedBox(height: 16),
            
            if (authState.error != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Text(authState.error!, style: TextStyle(color: Theme.of(context).colorScheme.error)),
              ),

            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Full Name'),
              validator: (v) => v == null || v.isEmpty ? 'Name is required' : null,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
              validator: (v) => v == null || v.isEmpty ? 'Email is required' : null,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _universityController,
              decoration: const InputDecoration(labelText: 'University'),
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _departmentController,
              decoration: const InputDecoration(labelText: 'Department'),
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _bioController,
              maxLines: 3,
              decoration: const InputDecoration(labelText: 'Bio'),
            ),
          ]),
        ),
        ),
      ),
    );
  }
}

class _InfoItem { final IconData icon; final String label, value; _InfoItem(this.icon, this.label, this.value); }
class _MenuItem { final IconData icon; final String label; final VoidCallback onTap; _MenuItem(this.icon, this.label, this.onTap); }
