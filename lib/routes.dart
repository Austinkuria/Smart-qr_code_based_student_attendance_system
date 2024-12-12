import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
import 'screens/dashboard_lecturer.dart';
import 'screens/dashboard_student.dart';
import 'screens/dashboard_admin.dart';
import 'screens/settings_screen.dart';
import 'screens/manage_classes.dart';
import 'screens/manage_lecturers.dart';
import 'screens/manage_students.dart';
import 'screens/attendance_reports.dart';

final Map<String, WidgetBuilder> routes = {
  '/': (context) => LoginScreen(),
  '/dashboard_student': (context) =>  DashboardStudent(),
  '/dashboard_lecturer': (context) =>  DashboardLecturer(),
  '/dashboard_admin': (context) =>  DashboardAdmin(),
  '/manage_classes': (context) => ManageClassesScreen(),
  '/manage_lecturers': (context) => ManageLecturersScreen(),
  '/manage_students': (context) => ManageStudentsScreen(),
  '/attendance_reports': (context) => AttendanceReportsScreen(),
  // '/scanner': (context) => ScannerScreen(),
  '/settings': (context) => SettingsScreen(),
};
