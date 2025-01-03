// app_routes.dart
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'screens/admin/dashboard_admin.dart';
import 'screens/lecturer/dashboard_lecturer.dart';
import 'screens/student/dashboard_student.dart';
import 'screens/error/error_page.dart';

class AppRoutes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    return MaterialPageRoute(
      builder: (context) {
        return FutureBuilder<String>(
          future: _getUserRoleFromStorage(), // Fetch role after login
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }

            if (snapshot.hasError) {
              return const ErrorPage(errorMessage: 'Error fetching role.');
            }

            String userRole = snapshot.data ?? 'student';

            return _getRouteForRole(userRole);
          },
        );
      },
    );
  }

  static Future<String> _getUserRoleFromStorage() async {
    var box = await Hive.openBox('userData');
    return box.get('role', defaultValue: 'student') ?? 'student';
  }

  static Widget _getRouteForRole(String role) {
    switch (role) {
      case 'admin':
        return const DashboardAdmin();
      case 'lecturer':
        return const DashboardLecturer();
      case 'student':
        return const DashboardStudent();
      default:
        return const ErrorPage(errorMessage: 'Invalid user role.');
    }
  }
}
