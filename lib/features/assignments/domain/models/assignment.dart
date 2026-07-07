import 'package:freezed_annotation/freezed_annotation.dart';

part 'assignment.freezed.dart';
part 'assignment.g.dart';

@freezed
class Assignment with _$Assignment {
  const factory Assignment({
    required String id,
    required String title,
    required String description,
    required String course,
    required DateTime dueDate,
    required String priority,
    required double progress,
    @Default(false) bool completed,
  }) = _Assignment;

  factory Assignment.fromJson(Map<String, dynamic> json) => _$AssignmentFromJson(json);
}
