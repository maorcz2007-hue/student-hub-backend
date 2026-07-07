import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/course_provider.dart';
import 'package:student_hub/core/widgets/glass_card.dart';

class AddCourseScreen extends ConsumerStatefulWidget {
  const AddCourseScreen({super.key});

  @override
  ConsumerState<AddCourseScreen> createState() => _AddCourseScreenState();
}

class _AddCourseScreenState extends ConsumerState<AddCourseScreen> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  String _code = '';
  int _credits = 3;

  void _submit() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      await ref.read(courseNotifierProvider.notifier).addCourse(
        name: _name,
        code: _code,
        credits: _credits,
      );
      if (mounted) {
        context.pop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final state = ref.watch(courseNotifierProvider);

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF000000) : const Color(0xFFF2F2F7),
      appBar: AppBar(
        title: const Text('Add Course'),
        backgroundColor: Colors.transparent,
      ),
      body: state.isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    GlassCard(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          TextFormField(
                            decoration: const InputDecoration(labelText: 'Course Name (e.g. Data Structures)'),
                            validator: (v) => v!.isEmpty ? 'Required' : null,
                            onSaved: (v) => _name = v!,
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            decoration: const InputDecoration(labelText: 'Course Code (e.g. CS201)'),
                            validator: (v) => v!.isEmpty ? 'Required' : null,
                            onSaved: (v) => _code = v!,
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            decoration: const InputDecoration(labelText: 'Credits (e.g. 3)'),
                            keyboardType: TextInputType.number,
                            validator: (v) => v!.isEmpty ? 'Required' : null,
                            onSaved: (v) => _credits = int.tryParse(v!) ?? 3,
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 50),
                        backgroundColor: theme.colorScheme.primary,
                        foregroundColor: Colors.white,
                      ),
                      onPressed: _submit,
                      child: const Text('Add Course'),
                    ),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
    );
  }
}
