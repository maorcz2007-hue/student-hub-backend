import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/repositories/course_repository.dart';
import '../../../dashboard/data/repositories/dashboard_repository_impl.dart';

final courseNotifierProvider = AsyncNotifierProvider<CourseNotifier, List<dynamic>>(() {
  return CourseNotifier();
});

class CourseNotifier extends AsyncNotifier<List<dynamic>> {
  @override
  Future<List<dynamic>> build() async {
    final repository = ref.watch(courseRepositoryProvider);
    return await repository.getCourses();
  }

  Future<void> addCourse({required String name, required String code, required int credits}) async {
    final repository = ref.read(courseRepositoryProvider);
    
    // Save previous state to rollback if needed
    final previousState = state;
    state = const AsyncValue.loading();
    
    try {
      await repository.addCourse(name: name, code: code, credits: credits);
      // Invalidate dashboard so it fetches the new list of courses
      ref.invalidate(dashboardRepositoryProvider);
      
      // Refresh this provider's data
      ref.invalidateSelf();
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}
