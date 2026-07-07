import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/models/assignment.dart';
import '../../data/repositories/assignment_repository_impl.dart';
import '../../../auth/presentation/providers/auth_provider.dart';

part 'assignments_provider.g.dart';

@riverpod
class AssignmentsNotifier extends _$AssignmentsNotifier {
  @override
  FutureOr<List<Assignment>> build() async {
    return _fetchAssignments();
  }

  Future<List<Assignment>> _fetchAssignments() async {
    // Read the current authenticated user's ID
    final user = ref.read(authStateProvider).user;
    if (user == null) return []; // Or throw an exception
    
    final repository = ref.read(assignmentRepositoryProvider);
    return repository.getAssignments(user.id);
  }

  Future<void> addAssignment({
    required String courseId,
    required String title,
    required String description,
    required DateTime dueDate,
    required String type,
    required String priority,
  }) async {
    final repository = ref.read(assignmentRepositoryProvider);
    
    // Set loading state
    state = const AsyncValue.loading();
    
    try {
      await repository.addAssignment(
        courseId: courseId,
        title: title,
        description: description,
        dueDate: dueDate,
        type: type,
        priority: priority,
      );
      
      // Refresh the provider to fetch the new list of assignments
      ref.invalidateSelf();
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}
