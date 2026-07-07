import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:student_hub/app/router/route_names.dart';
import 'package:student_hub/features/auth/presentation/providers/auth_provider.dart';
import 'package:student_hub/features/auth/presentation/screens/login_screen.dart';
import 'package:student_hub/features/auth/presentation/screens/register_screen.dart';
import 'package:student_hub/features/auth/presentation/screens/forgot_password_screen.dart';
import 'package:student_hub/features/dashboard/presentation/screens/dashboard_screen.dart';
import 'package:student_hub/features/assignments/presentation/screens/assignments_list_screen.dart';
import 'package:student_hub/features/assignments/presentation/screens/assignment_detail_screen.dart';
import 'package:student_hub/features/assignments/presentation/screens/create_assignment_screen.dart';
import 'package:student_hub/features/grades/presentation/screens/grades_overview_screen.dart';
import 'package:student_hub/features/calendar/presentation/screens/calendar_screen.dart';
import 'package:student_hub/features/courses/presentation/screens/courses_list_screen.dart';
import 'package:student_hub/features/courses/presentation/screens/course_detail_screen.dart';
import 'package:student_hub/features/courses/presentation/screens/add_course_screen.dart';
import 'package:student_hub/features/academic_progress/presentation/screens/progress_screen.dart';
import 'package:student_hub/features/ai_assistant/presentation/screens/ai_chat_screen.dart';
import 'package:student_hub/features/messaging/presentation/screens/conversations_screen.dart';
import 'package:student_hub/features/messaging/presentation/screens/chat_screen.dart';
import 'package:student_hub/features/notifications/presentation/screens/notifications_screen.dart';
import 'package:student_hub/features/profile/presentation/screens/profile_screen.dart';
import 'package:student_hub/features/profile/presentation/screens/edit_profile_screen.dart';
import 'package:student_hub/features/settings/presentation/screens/settings_screen.dart';
import 'package:student_hub/features/settings/presentation/screens/appearance_screen.dart';
import 'package:student_hub/features/search/presentation/screens/global_search_screen.dart';
import 'package:student_hub/features/files/presentation/screens/file_manager_screen.dart';
import 'package:student_hub/features/feedback/presentation/screens/feedback_screen.dart';
import 'package:student_hub/features/feedback/presentation/screens/submit_feedback_screen.dart';
import 'package:student_hub/features/admin/presentation/screens/admin_dashboard_screen.dart';
import 'package:student_hub/app/shell/main_shell.dart';

/// Global navigator keys for nested navigation.
final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

/// GoRouter provider with authentication-based redirect.
final routerProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authStateProvider);

  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/dashboard',
    debugLogDiagnostics: true,

    // ── Auth Redirect ──
    redirect: (context, state) {
      final isLoggedIn = authState.isAuthenticated;
      final isAuthRoute = state.matchedLocation.startsWith('/auth');

      if (!isLoggedIn && !isAuthRoute) {
        return '/auth/login';
      }
      if (isLoggedIn && isAuthRoute) {
        return '/dashboard';
      }
      return null;
    },

    routes: [
      // ── Auth Routes (no shell) ──
      GoRoute(
        path: '/auth/login',
        name: RouteNames.login,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/auth/register',
        name: RouteNames.register,
        builder: (context, state) => const RegisterScreen(),
      ),
      GoRoute(
        path: '/auth/forgot-password',
        name: RouteNames.forgotPassword,
        builder: (context, state) => const ForgotPasswordScreen(),
      ),

      // ── Main App Shell (with bottom nav) ──
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (context, state, child) => MainShell(child: child),
        routes: [
          // Dashboard
          GoRoute(
            path: '/dashboard',
            name: RouteNames.dashboard,
            pageBuilder: (context, state) => _fadeTransition(
              state,
              const DashboardScreen(),
            ),
          ),

          // Assignments
          GoRoute(
            path: '/assignments',
            name: RouteNames.assignments,
            pageBuilder: (context, state) => _fadeTransition(
              state,
              const AssignmentsListScreen(),
            ),
            routes: [
              GoRoute(
                path: 'create',
                name: RouteNames.createAssignment,
                parentNavigatorKey: _rootNavigatorKey,
                builder: (context, state) => const CreateAssignmentScreen(),
              ),
              GoRoute(
                path: ':id',
                name: RouteNames.assignmentDetail,
                parentNavigatorKey: _rootNavigatorKey,
                builder: (context, state) => AssignmentDetailScreen(
                  assignmentId: state.pathParameters['id']!,
                ),
              ),
            ],
          ),

          // Grades
          GoRoute(
            path: '/grades',
            name: RouteNames.grades,
            pageBuilder: (context, state) => _fadeTransition(
              state,
              const GradesOverviewScreen(),
            ),
          ),

          // Calendar
          GoRoute(
            path: '/calendar',
            name: RouteNames.calendar,
            pageBuilder: (context, state) => _fadeTransition(
              state,
              const CalendarScreen(),
            ),
          ),

          // Profile
          GoRoute(
            path: '/profile',
            name: RouteNames.profile,
            pageBuilder: (context, state) => _fadeTransition(
              state,
              const ProfileScreen(),
            ),
          ),
        ],
      ),

      // ── Full-screen routes (outside shell) ──
      GoRoute(
        path: '/courses',
        name: RouteNames.courses,
        builder: (context, state) => const CoursesListScreen(),
        routes: [
          GoRoute(
            path: 'add',
            name: RouteNames.addCourse,
            builder: (context, state) => const AddCourseScreen(),
          ),
          GoRoute(
            path: ':id',
            name: RouteNames.courseDetail,
            builder: (context, state) => CourseDetailScreen(
              courseId: state.pathParameters['id']!,
            ),
          ),
        ],
      ),
      GoRoute(
        path: '/academic-progress',
        name: RouteNames.academicProgress,
        builder: (context, state) => const ProgressScreen(),
      ),
      GoRoute(
        path: '/ai-assistant',
        name: RouteNames.aiAssistant,
        builder: (context, state) => const AiChatScreen(),
      ),
      GoRoute(
        path: '/messaging',
        name: RouteNames.messaging,
        builder: (context, state) => const ConversationsScreen(),
        routes: [
          GoRoute(
            path: ':id',
            name: RouteNames.chat,
            builder: (context, state) => ChatScreen(
              conversationId: state.pathParameters['id']!,
            ),
          ),
        ],
      ),
      GoRoute(
        path: '/notifications',
        name: RouteNames.notifications,
        builder: (context, state) => const NotificationsScreen(),
      ),
      GoRoute(
        path: '/edit-profile',
        name: RouteNames.editProfile,
        builder: (context, state) => const EditProfileScreen(),
      ),
      GoRoute(
        path: '/settings',
        name: RouteNames.settings,
        builder: (context, state) => const SettingsScreen(),
        routes: [
          GoRoute(
            path: 'appearance',
            name: RouteNames.appearance,
            builder: (context, state) => const AppearanceScreen(),
          ),
        ],
      ),
      GoRoute(
        path: '/search',
        name: RouteNames.search,
        builder: (context, state) => const GlobalSearchScreen(),
      ),
      GoRoute(
        path: '/files',
        name: RouteNames.fileManager,
        builder: (context, state) => const FileManagerScreen(),
      ),
      GoRoute(
        path: '/feedback',
        name: RouteNames.feedback,
        builder: (context, state) => const FeedbackScreen(),
        routes: [
          GoRoute(
            path: 'submit',
            name: RouteNames.submitFeedback,
            builder: (context, state) => const SubmitFeedbackScreen(),
          ),
        ],
      ),
      GoRoute(
        path: '/admin',
        name: RouteNames.adminDashboard,
        builder: (context, state) => const AdminDashboardScreen(),
      ),
    ],

    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 64, color: Theme.of(context).colorScheme.error),
            const SizedBox(height: 16),
            Text(
              'Page not found',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 8),
            Text(
              state.error?.message ?? 'Unknown error',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => context.go('/dashboard'),
              child: const Text('Go Home'),
            ),
          ],
        ),
      ),
    ),
  );
});

/// Custom fade transition for bottom navigation tab switching.
CustomTransitionPage _fadeTransition(GoRouterState state, Widget child) {
  return CustomTransitionPage(
    key: state.pageKey,
    child: child,
    transitionDuration: const Duration(milliseconds: 200),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(
        opacity: CurveTween(curve: Curves.easeInOut).animate(animation),
        child: child,
      );
    },
  );
}
