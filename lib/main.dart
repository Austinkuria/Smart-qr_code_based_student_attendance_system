import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'services/hive_service.dart'; // Import HiveService
import 'app_routes.dart';
import 'screens/common/splash_screen.dart'; // Import SplashScreen

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive and register adapters
  await Hive.initFlutter();
  await HiveService.initializeHive();
  await HiveService().initializeUsers();
  await Hive.openBox('userData'); // Open the box

  // Run the app after initializing
  runApp(const MyApp(role: 'user')); // Provide the required 'role' argument
}

class MyApp extends StatelessWidget {
final String role;

const MyApp({super.key, required this.role});
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart QR Code Attendance System',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      onGenerateRoute: (RouteSettings settings) {
        return AppRoutes.generateRoute(settings); // Handle role-based routing in AppRoutes
      },
      home: const SplashScreen(), // Start with SplashScreen
    );
  }
}
