import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/models/dashboard_data.dart';
import '../../data/repositories/dashboard_repository_impl.dart';
import '../../../auth/presentation/providers/auth_provider.dart';

part 'dashboard_provider.g.dart';

@riverpod
class DashboardNotifier extends _$DashboardNotifier {
  @override
  FutureOr<DashboardData?> build() async {
    return _fetchDashboardData();
  }

  Future<DashboardData?> _fetchDashboardData() async {
    final user = ref.watch(authStateProvider).user;
    if (user == null) return null;
    
    final repository = ref.read(dashboardRepositoryProvider);
    return repository.getDashboardData(user.id);
  }
}
