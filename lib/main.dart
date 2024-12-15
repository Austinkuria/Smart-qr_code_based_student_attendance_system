import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'services/hive_service.dart'; // Import HiveService
import 'app_routes.dart';
// import 'screens/error/not_found_page.dart'; // Import ErrorScreen
import 'screens/common/splash_screen.dart'; // Import SplashScreen

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Hive and register adapters
  await Hive.initFlutter();
  await HiveService.initializeHive();
  await HiveService().initializeUsers();

  // Open userData box to fetch the role and other data
  await Hive.openBox('userData');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Future<String> getUserRole() async {
    var box = await Hive.openBox('userData');
    String role = box.get('role', defaultValue: 'student'); // Default to 'student'
    debugPrint('Retrieved user role: $role');
    return role;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart QR Code Attendance System',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FutureBuilder<String>(
        future: getUserRole(), // Fetch role asynchronously
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const SplashScreen(); // Show loading screen while fetching role
          }

          if (snapshot.hasError) {
            return const ErrorScreen(); // Handle error if any
          }

          if (snapshot.hasData) {
            String role = snapshot.data ?? 'student'; // Default to 'student' if no data
            return MaterialApp(
              title: 'Smart QR Code Attendance System',
              theme: ThemeData(
                primarySwatch: Colors.blue,
              ),
              onGenerateRoute: (RouteSettings settings) {
                return AppRoutes.generateRoute(settings, role); // Pass role for routing
              },
              home: const SplashScreen(), // Use this if you need an initial screen
            );
          } else {
            return const ErrorScreen(); // Fallback if no data available
          }
        },
      ),
    );
  }
}

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Failed to load user role'), // Handle error here
      ),
    );
  }
}
