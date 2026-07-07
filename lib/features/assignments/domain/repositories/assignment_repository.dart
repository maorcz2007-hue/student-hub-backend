import '../models/assignment.dart';

abstract class AssignmentRepository {
  Future<List<Assignment>> getAssignments(String userId);
  Future<void> addAssignment({
    required String courseId,
    required String title,
    required String description,
    required DateTime dueDate,
    required String type,
    required String priority,
  });
}
