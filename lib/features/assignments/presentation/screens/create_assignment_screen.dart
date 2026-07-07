import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:go_router/go_router.dart';
import '../providers/assignments_provider.dart';
import '../../../courses/presentation/providers/course_provider.dart';

class CreateAssignmentScreen extends ConsumerStatefulWidget {
  const CreateAssignmentScreen({super.key});

  @override
  ConsumerState<CreateAssignmentScreen> createState() => _CreateAssignmentScreenState();
}

class _CreateAssignmentScreenState extends ConsumerState<CreateAssignmentScreen> {
  final _formKey = GlobalKey<FormState>();
  String _title = '';
  String _description = '';
  String? _courseId;
  DateTime _dueDate = DateTime.now().add(const Duration(days: 1));
  String _priority = 'MEDIUM';
  String _type = 'HOMEWORK';

  void _submit() async {
    if (_formKey.currentState!.validate()) {
      if (_courseId == null) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please select a course')));
        return;
      }
      _formKey.currentState!.save();
      await ref.read(assignmentsNotifierProvider.notifier).addAssignment(
        courseId: _courseId!,
        title: _title,
        description: _description,
        dueDate: _dueDate,
        type: _type,
        priority: _priority,
      );
      if (mounted) {
        context.pop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final coursesState = ref.watch(courseNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('New Assignment'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                decoration: const InputDecoration(hintText: 'Title', prefixIcon: Icon(Iconsax.edit_2)),
                validator: (v) => v!.isEmpty ? 'Required' : null,
                onSaved: (v) => _title = v!,
              ),
              const SizedBox(height: 16),
              TextFormField(
                maxLines: 4, 
                decoration: const InputDecoration(hintText: 'Description', alignLabelWithHint: true),
                onSaved: (v) => _description = v ?? '',
              ),
              const SizedBox(height: 16),
              coursesState.when(
                data: (courses) => DropdownButtonFormField<String>(
                  decoration: const InputDecoration(hintText: 'Select Course', prefixIcon: Icon(Iconsax.book_1)),
                  items: courses.map<DropdownMenuItem<String>>((c) => DropdownMenuItem(value: c['id'], child: Text(c['name']))).toList(),
                  onChanged: (v) => setState(() => _courseId = v),
                ),
                loading: () => const CircularProgressIndicator(),
                error: (err, st) => Text('Error loading courses: $err'),
              ),
              const SizedBox(height: 16),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Iconsax.calendar_1),
                title: Text('Due: ${_dueDate.toString().split(' ')[0]}'),
                trailing: const Icon(Icons.arrow_drop_down),
                onTap: () async {
                  final date = await showDatePicker(context: context, initialDate: _dueDate, firstDate: DateTime.now(), lastDate: DateTime(2030));
                  if (date != null) setState(() => _dueDate = date);
                },
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(hintText: 'Priority', prefixIcon: Icon(Iconsax.flag)),
                value: 'MEDIUM',
                items: ['LOW', 'MEDIUM', 'HIGH'].map((p) => DropdownMenuItem(value: p, child: Text(p))).toList(),
                onChanged: (v) => _priority = v!,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(hintText: 'Category', prefixIcon: Icon(Iconsax.category)),
                value: 'HOMEWORK',
                items: ['HOMEWORK', 'PROJECT', 'LAB', 'EXAM', 'PERSONAL'].map((c) => DropdownMenuItem(value: c, child: Text(c))).toList(),
                onChanged: (v) => _type = v!,
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(onPressed: _submit, child: const Text('Create Assignment')),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
