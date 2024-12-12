// lib/main.dart

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'models/user.dart';
import 'services/hive_service.dart';
import 'screens/login_screen.dart';
import 'screens/dashboard_admin.dart';
import 'screens/dashboard_lecturer.dart';
import 'screens/dashboard_student.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  // Register Hive adapters
  Hive.registerAdapter(UserModelAdapter());

  // Initialize user data
  var hiveService = HiveService();
  await hiveService.initializeUsers();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Attendance System',
      initialRoute: '/',
      routes: {
        '/': (context) => LoginScreen(),
        '/dashboard_admin': (context) => DashboardAdmin(),
        '/dashboard_lecturer': (context) => DashboardLecturer(),
        '/dashboard_student': (context) => DashboardStudent(),
      },
    );
  }
}