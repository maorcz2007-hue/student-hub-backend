import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/models/assignment.dart';
import '../../domain/repositories/assignment_repository.dart';
import 'package:student_hub/core/network/api_client.dart';

final assignmentRepositoryProvider = Provider<AssignmentRepository>((ref) {
  final apiClient = ref.watch(apiClientProvider);
  return AssignmentRepositoryImpl(apiClient);
});

class AssignmentRepositoryImpl implements AssignmentRepository {
  final ApiClient _apiClient;

  AssignmentRepositoryImpl(this._apiClient);

  @override
  Future<List<Assignment>> getAssignments(String userId) async {
    try {
      final response = await _apiClient.get('/assignments');
      final data = response.data as List<dynamic>;
      
      return data.map((json) {
        return Assignment(
          id: json['id'] ?? '',
          title: json['title'] ?? '',
          description: json['description'] ?? '',
          course: json['course']?['name'] ?? '',
          dueDate: json['dueDate'] != null ? DateTime.parse(json['dueDate']) : DateTime.now(),
          priority: (json['priority'] ?? 'MEDIUM').toLowerCase(),
          progress: (json['submissions'] != null && json['submissions'].isNotEmpty) ? 1.0 : 0.0,
          completed: (json['submissions'] != null && json['submissions'].isNotEmpty),
        );
      }).toList();
    } catch (e) {
      throw Exception('Failed to load assignments: $e');
    }
  }

  @override
  Future<void> addAssignment({
    required String courseId,
    required String title,
    required String description,
    required DateTime dueDate,
    required String type,
    required String priority,
  }) async {
    try {
      await _apiClient.post('/assignments', data: {
        'courseId': courseId,
        'title': title,
        'description': description,
        'dueDate': dueDate.toIso8601String(),
        'type': type.toUpperCase(),
        'priority': priority.toUpperCase(),
      });
    } catch (e) {
      throw Exception('Failed to add assignment: $e');
    }
  }
}
