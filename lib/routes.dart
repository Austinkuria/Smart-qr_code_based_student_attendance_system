import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
import 'screens/dashboard_lecturer.dart';
import 'screens/dashboard_student.dart';
import 'screens/dashboard_admin.dart';
import 'screens/settings_screen.dart';

final Map<String, WidgetBuilder> routes = {
  '/': (context) => LoginScreen(),
  '/dashboard_student': (context) => const DashboardStudent(),
  '/dashboard_lecturer': (context) => const DashboardLecturer(),
  '/dashboard_admin': (context) => const DashboardAdmin(),
  // '/scanner': (context) => ScannerScreen(),
  '/settings': (context) => SettingsScreen(),
};
