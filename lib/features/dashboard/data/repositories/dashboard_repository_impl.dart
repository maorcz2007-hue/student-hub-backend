import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/models/dashboard_data.dart';
import '../../domain/repositories/dashboard_repository.dart';
import 'package:student_hub/core/network/api_client.dart';

final dashboardRepositoryProvider = Provider<DashboardRepository>((ref) {
  final apiClient = ref.watch(apiClientProvider);
  return DashboardRepositoryImpl(apiClient);
});

class DashboardRepositoryImpl implements DashboardRepository {
  final ApiClient _apiClient;

  DashboardRepositoryImpl(this._apiClient);

  @override
  Future<DashboardData> getDashboardData(String userId) async {
    try {
      final response = await _apiClient.get('/dashboard');
      final data = response.data;
      
      // Map API response to our existing DashboardData model
      return DashboardData(
        gpa: (data['gpa'] as num?)?.toDouble() ?? 4.0,
        academicStanding: data['academicStanding'] ?? "Good Standing",
        completedCredits: data['completedCredits'] ?? 0,
        totalCredits: data['totalCredits'] ?? 120,
        semesterCreditsCompleted: data['semesterCreditsCompleted'] ?? 0,
        semesterCreditsTotal: data['semesterCreditsTotal'] ?? 0,
        pendingTasks: data['pendingTasks'] ?? 0,
        avgGrade: (data['avgGrade'] as num?)?.toDouble() ?? 0.0,
        activeCourses: data['activeCourses'] ?? 0,
        studyTimeHours: data['studyTimeHours'] ?? 0,
        todaySchedule: (data['todaySchedule'] as List<dynamic>?)?.map((e) => ScheduleItem(
          name: e['name'],
          time: e['time'],
          location: e['location'],
          colorValue: e['colorValue'] ?? 0xFF1E88E5,
          isNow: e['isNow'] ?? false,
        )).toList() ?? [],
        upcomingDeadlines: (data['upcomingDeadlines'] as List<dynamic>?)?.map((e) => DeadlineItem(
          title: e['title'],
          due: e['due'],
          colorValue: e['colorValue'] ?? 0xFF1E88E5,
          progress: (e['progress'] as num?)?.toDouble() ?? 0.0,
        )).toList() ?? [],
        gradeTrend: (data['gradeTrend'] as List<dynamic>?)?.map((e) => GradeTrendSpot(
          monthIndex: e['monthIndex'],
          score: (e['score'] as num?)?.toDouble() ?? 0.0,
        )).toList() ?? [],
        aiSuggestion: data['aiSuggestion'] ?? "Welcome to your student dashboard!",
      );
    } catch (e) {
      throw Exception('Failed to load dashboard data: $e');
    }
  }
}
