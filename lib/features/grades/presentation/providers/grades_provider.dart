import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_hub/core/network/api_client.dart';

class GradeModel {
  final String id;
  final String courseId;
  final String? assignmentId;
  final double score;
  final double maxScore;
  final String semester;
  final DateTime gradedAt;
  final dynamic course;

  GradeModel({
    required this.id,
    required this.courseId,
    this.assignmentId,
    required this.score,
    required this.maxScore,
    required this.semester,
    required this.gradedAt,
    this.course,
  });

  factory GradeModel.fromJson(Map<String, dynamic> json) {
    return GradeModel(
      id: json['id'],
      courseId: json['courseId'],
      assignmentId: json['assignmentId'],
      score: (json['score'] as num).toDouble(),
      maxScore: (json['maxScore'] as num).toDouble(),
      semester: json['semester'],
      gradedAt: DateTime.parse(json['gradedAt']),
      course: json['course'],
    );
  }
}

final gradesProvider = FutureProvider<List<GradeModel>>((ref) async {
  final apiClient = ref.watch(apiClientProvider);
  final response = await apiClient.get('/grades');
  return (response.data as List).map((e) => GradeModel.fromJson(e)).toList();
});
