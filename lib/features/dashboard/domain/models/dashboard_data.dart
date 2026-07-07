import 'package:freezed_annotation/freezed_annotation.dart';

part 'dashboard_data.freezed.dart';
part 'dashboard_data.g.dart';

@freezed
class DashboardData with _$DashboardData {
  const factory DashboardData({
    required double gpa,
    required String academicStanding,
    required int completedCredits,
    required int totalCredits,
    required int semesterCreditsCompleted,
    required int semesterCreditsTotal,
    required int pendingTasks,
    required double avgGrade,
    required int activeCourses,
    required int studyTimeHours,
    required List<ScheduleItem> todaySchedule,
    required List<DeadlineItem> upcomingDeadlines,
    required List<GradeTrendSpot> gradeTrend,
    required String aiSuggestion,
  }) = _DashboardData;

  factory DashboardData.fromJson(Map<String, dynamic> json) => _$DashboardDataFromJson(json);
}

@freezed
class ScheduleItem with _$ScheduleItem {
  const factory ScheduleItem({
    required String name,
    required String time,
    required String location,
    required int colorValue, // To store color cleanly
    required bool isNow,
  }) = _ScheduleItem;

  factory ScheduleItem.fromJson(Map<String, dynamic> json) => _$ScheduleItemFromJson(json);
}

@freezed
class DeadlineItem with _$DeadlineItem {
  const factory DeadlineItem({
    required String title,
    required String due,
    required int colorValue,
    required double progress,
  }) = _DeadlineItem;

  factory DeadlineItem.fromJson(Map<String, dynamic> json) => _$DeadlineItemFromJson(json);
}

@freezed
class GradeTrendSpot with _$GradeTrendSpot {
  const factory GradeTrendSpot({
    required double monthIndex,
    required double score,
  }) = _GradeTrendSpot;

  factory GradeTrendSpot.fromJson(Map<String, dynamic> json) => _$GradeTrendSpotFromJson(json);
}
