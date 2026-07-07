// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'assignment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AssignmentImpl _$$AssignmentImplFromJson(Map<String, dynamic> json) =>
    _$AssignmentImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      course: json['course'] as String,
      dueDate: DateTime.parse(json['dueDate'] as String),
      priority: json['priority'] as String,
      progress: (json['progress'] as num).toDouble(),
      completed: json['completed'] as bool? ?? false,
    );

Map<String, dynamic> _$$AssignmentImplToJson(_$AssignmentImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'course': instance.course,
      'dueDate': instance.dueDate.toIso8601String(),
      'priority': instance.priority,
      'progress': instance.progress,
      'completed': instance.completed,
    };
