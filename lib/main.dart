import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'models/user.dart';
import 'models/attendance.dart';
import 'models/class.dart';
import 'models/feedback.dart';
import 'models/audit_log.dart';
import 'models/notification.dart';
import 'models/qr_code.dart';
import 'models/session.dart';
import 'models/system_setting.dart';
import 'services/hive_service.dart';
import 'app_routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  // Register Hive adapters for new models
  Hive.registerAdapter(UserModelAdapter());
  Hive.registerAdapter(AttendanceModelAdapter());
  Hive.registerAdapter(ClassAdapter());
  Hive.registerAdapter(FeedbackAdapter());
  Hive.registerAdapter(AuditLogModelAdapter());
  Hive.registerAdapter(NotificationAdapter());
  Hive.registerAdapter(QRCodeAdapter());
  Hive.registerAdapter(SessionAdapter());
  Hive.registerAdapter(SystemSettingAdapter());

  // Initialize user data
  var hiveService = HiveService();
  await hiveService.initializeUsers();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Future<String> getUserRole() async {
    // Retrieve the user role from local storage or user session
    var box = await Hive.openBox('userData');
    return box.get('role', defaultValue: 'student'); // Default to 'student'
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: getUserRole(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator(); // Show loading while fetching role
        }

        if (snapshot.hasData) {
          String userRole = snapshot.data!;
          return MaterialApp(
            title: 'QR Attendance System',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            initialRoute: AppRoutes.splashScreen,
            onGenerateRoute: (settings) => AppRoutes.generateRoute(settings, userRole),
          );
        } else {
          return const Scaffold(
            body: Center(
              child: Text('Failed to load user role'),
            ),
          );
        }
      },
    );
  }
}
