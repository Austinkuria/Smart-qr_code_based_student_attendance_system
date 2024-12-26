import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

// Admin Screens
import 'screens/admin/attendance_reports.dart';
import 'screens/admin/audit_logs_screen.dart';
import 'screens/admin/dashboard_admin.dart';
import 'screens/admin/manage_classes.dart' as admin_classes;
import 'screens/admin/manage_lecturers.dart';
import 'screens/admin/manage_students.dart';
import 'screens/admin/reporting_screen.dart';
import 'screens/admin/settings_screen.dart' as admin_settings;
import 'screens/admin/system_notifications.dart';
import 'screens/admin/user_activity_monitor.dart';

// Common Screens
// import 'screens/common/change_password_screen.dart';
// import 'screens/common/forgot_password_screen.dart';
// import 'screens/common/help_center_screen.dart';
import 'screens/common/login_screen.dart';
// import 'screens/common/notifications_screen.dart' as common_notifications;
// import 'screens/common/settings_screen.dart' as common_settings;
// import 'screens/common/splash_screen.dart';
// import 'screens/common/terms_conditions_screen.dart';
// import 'screens/common/update_profile_screen.dart';

// Lecturer Screens
import 'screens/lecturer/attendance_reports.dart' as lecturer_reports;
import 'screens/lecturer/class_attendance_summary.dart';
import 'screens/lecturer/dashboard_lecturer.dart';
import 'screens/lecturer/manage_classes.dart';
import 'screens/lecturer/notifications_screen.dart' as lecturer_notifications;
import 'screens/lecturer/schedule_class.dart';
import 'screens/lecturer/generate_qr_code_screen.dart';
import 'screens/lecturer/settings_screen.dart' as lecturer_settings;
import 'screens/lecturer/student_feedback_screen.dart';

// Student Screens
import 'screens/student/attendance_records.dart';
import 'screens/student/dashboard_student.dart';
import 'screens/student/attendance_summary_screen.dart';
import 'screens/student/feedback_screen.dart';
import 'screens/student/help_support_screen.dart';
import 'screens/student/my_classes_screen.dart';
import 'screens/student/notifications_screen.dart' as student_notifications;
import 'screens/student/scan_attendance_screen.dart';
import 'screens/student/settings_screen.dart' as student_settings;

// Error Screens
import 'screens/error/error_page.dart';
import 'screens/error/not_found_page.dart';



class AppRoutes {
  static const splashScreen = '/';

  // This is the main route generator
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Fetch the user role from Hive or other local storage
    return MaterialPageRoute(
      builder: (context) {
        return FutureBuilder<String>(
          future: _getUserRoleFromStorage(), // Fetch role after login
          builder: (context, snapshot) {
            // If role is still loading, show a loading screen
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }

            // Handle error in fetching role
            if (snapshot.hasError) {
              return const ErrorPage(errorMessage: 'Error fetching role.');
            }

            // Now that we have the user role, handle route generation
            String userRole = snapshot.data ?? 'student'; // Default to 'student' if no role found

            // Get the role-specific routes based on the fetched role
            Map<String, WidgetBuilder> roleRoutes = getRoleRoutes(userRole);

            // Return the route based on the settings name, or fall back to a NotFound page if undefined
            final WidgetBuilder builder = roleRoutes[settings.name] ?? (context) => const NotFoundPage();
            return builder(context);
          },
        );
      },
    );
  }

  // Method to fetch the user role from Hive or other persistent storage
  static Future<String> _getUserRoleFromStorage() async {
    var box = await Hive.openBox('userData');
    return box.get('role', defaultValue: 'student') ?? 'student'; // Default to 'student' if no role found
  }

    // Generate role-specific routes
  static Map<String, WidgetBuilder> getRoleRoutes(String role) {
    debugPrint('getRoleRoutes: Role = $role'); // Debugging the role value

    switch (role) {
      case 'admin':
        return {
          '/dashboard_admin': (context) => const DashboardAdmin(),
          '/manage_classes': (context) => const admin_classes.ManageClassesScreen(),
          '/manage_lecturers': (context) => const ManageLecturersScreen(),
          '/manage_students': (context) => const ManageStudentsScreen(),
          '/attendance_reports': (context) => const AttendanceReportsScreen(),
          '/audit_logs': (context) => const AuditLogsScreen(),
          '/reporting': (context) => const ReportingScreen(),
          '/system_notifications': (context) => const SystemNotificationsScreen(),
          '/settings_screen': (context) => const admin_settings.SettingsScreen(),
          '/user_activity_monitor': (context) => const UserActivityMonitorScreen(),
        };
      case 'lecturer':
        return {
          '/dashboard_lecturer': (context) => const DashboardLecturer(),
          '/attendance_reports': (context) => const lecturer_reports.AttendanceReportsScreen(),
          '/class_attendance_summary': (context) => const ClassAttendanceSummaryScreen(),
          '/manage_classes': (context) => const ManageClassesScreen(),
          '/schedule_class': (context) => const ScheduleClass(),
          '/generate_qr_code_screen': (context) => const GenerateQRCodeScreen(),
          '/student_feedback': (context) => const StudentFeedbackScreen(),
          '/lecturer_notifications': (context) => const lecturer_notifications.NotificationsScreen(),
          '/settings_screen': (context) => const lecturer_settings.SettingsScreen(),
          '/logout': (context) => const LoginScreen(),
        };
      case 'student':
        return {
          '/student_dashboard': (context) => DashboardStudent(),
          '/attendance_records': (context) => const AttendanceRecords(),
          '/attendance_summary': (context) => const AttendanceSummaryScreen(),
          '/feedback': (context) => const FeedbackScreen(),
          '/help_support': (context) => const HelpSupportScreen(),
          '/my_classes': (context) => const MyClassesScreen(),
          '/scan_attendance': (context) => const ScanAttendanceScreen(),
          '/student_notifications': (context) => const student_notifications.NotificationsScreen(),
          '/settings_screen': (context) => const student_settings.SettingsScreen(),
        };
      default:
        // Return empty map if role doesn't match, could also return a NotFound route here
        return {
          '/error': (context) => const ErrorPage(errorMessage: 'Invalid user role detected.'),
        };
    }
  }
}
