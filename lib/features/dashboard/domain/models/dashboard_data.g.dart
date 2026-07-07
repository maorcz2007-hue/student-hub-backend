// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DashboardDataImpl _$$DashboardDataImplFromJson(Map<String, dynamic> json) =>
    _$DashboardDataImpl(
      gpa: (json['gpa'] as num).toDouble(),
      academicStanding: json['academicStanding'] as String,
      completedCredits: (json['completedCredits'] as num).toInt(),
      totalCredits: (json['totalCredits'] as num).toInt(),
      semesterCreditsCompleted:
          (json['semesterCreditsCompleted'] as num).toInt(),
      semesterCreditsTotal: (json['semesterCreditsTotal'] as num).toInt(),
      pendingTasks: (json['pendingTasks'] as num).toInt(),
      avgGrade: (json['avgGrade'] as num).toDouble(),
      activeCourses: (json['activeCourses'] as num).toInt(),
      studyTimeHours: (json['studyTimeHours'] as num).toInt(),
      todaySchedule: (json['todaySchedule'] as List<dynamic>)
          .map((e) => ScheduleItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      upcomingDeadlines: (json['upcomingDeadlines'] as List<dynamic>)
          .map((e) => DeadlineItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      gradeTrend: (json['gradeTrend'] as List<dynamic>)
          .map((e) => GradeTrendSpot.fromJson(e as Map<String, dynamic>))
          .toList(),
      aiSuggestion: json['aiSuggestion'] as String,
    );

Map<String, dynamic> _$$DashboardDataImplToJson(_$DashboardDataImpl instance) =>
    <String, dynamic>{
      'gpa': instance.gpa,
      'academicStanding': instance.academicStanding,
      'completedCredits': instance.completedCredits,
      'totalCredits': instance.totalCredits,
      'semesterCreditsCompleted': instance.semesterCreditsCompleted,
      'semesterCreditsTotal': instance.semesterCreditsTotal,
      'pendingTasks': instance.pendingTasks,
      'avgGrade': instance.avgGrade,
      'activeCourses': instance.activeCourses,
      'studyTimeHours': instance.studyTimeHours,
      'todaySchedule': instance.todaySchedule,
      'upcomingDeadlines': instance.upcomingDeadlines,
      'gradeTrend': instance.gradeTrend,
      'aiSuggestion': instance.aiSuggestion,
    };

_$ScheduleItemImpl _$$ScheduleItemImplFromJson(Map<String, dynamic> json) =>
    _$ScheduleItemImpl(
      name: json['name'] as String,
      time: json['time'] as String,
      location: json['location'] as String,
      colorValue: (json['colorValue'] as num).toInt(),
      isNow: json['isNow'] as bool,
    );

Map<String, dynamic> _$$ScheduleItemImplToJson(_$ScheduleItemImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'time': instance.time,
      'location': instance.location,
      'colorValue': instance.colorValue,
      'isNow': instance.isNow,
    };

_$DeadlineItemImpl _$$DeadlineItemImplFromJson(Map<String, dynamic> json) =>
    _$DeadlineItemImpl(
      title: json['title'] as String,
      due: json['due'] as String,
      colorValue: (json['colorValue'] as num).toInt(),
      progress: (json['progress'] as num).toDouble(),
    );

Map<String, dynamic> _$$DeadlineItemImplToJson(_$DeadlineItemImpl instance) =>
    <String, dynamic>{
      'title': instance.title,
      'due': instance.due,
      'colorValue': instance.colorValue,
      'progress': instance.progress,
    };

_$GradeTrendSpotImpl _$$GradeTrendSpotImplFromJson(Map<String, dynamic> json) =>
    _$GradeTrendSpotImpl(
      monthIndex: (json['monthIndex'] as num).toDouble(),
      score: (json['score'] as num).toDouble(),
    );

Map<String, dynamic> _$$GradeTrendSpotImplToJson(
        _$GradeTrendSpotImpl instance) =>
    <String, dynamic>{
      'monthIndex': instance.monthIndex,
      'score': instance.score,
    };
