import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_hub/core/network/api_client.dart';

final courseRepositoryProvider = Provider<CourseRepository>((ref) {
  final apiClient = ref.watch(apiClientProvider);
  return CourseRepository(apiClient);
});

class CourseRepository {
  final ApiClient _apiClient;

  CourseRepository(this._apiClient);

  Future<List<dynamic>> getCourses() async {
    try {
      final response = await _apiClient.get('/courses');
      return response.data as List<dynamic>;
    } catch (e) {
      throw Exception('Failed to fetch courses: $e');
    }
  }

  Future<void> addCourse({
    required String name,
    required String code,
    required int credits,
  }) async {
    try {
      await _apiClient.post('/courses', data: {
        'name': name,
        'code': code,
        'credits': credits,
      });
    } catch (e) {
      throw Exception('Failed to add course: $e');
    }
  }
}
