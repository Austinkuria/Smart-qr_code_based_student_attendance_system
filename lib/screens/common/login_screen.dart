import 'package:flutter/material.dart';
import '../../services/user_service.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:logger/logger.dart'; // Initialize logger
import '../../models/user.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final UserService _userService = UserService(); // Use UserService to fetch user
  final Logger _logger = Logger(); // Initialize logger

  final FocusNode _usernameFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  final String _nextRoute = ''; // Variable to store the next route

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _usernameFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  // In login_screen.dart

void _login() async {
  String username = _usernameController.text.trim();
  String password = _passwordController.text.trim();

  // Log attempt
  _logger.i('Attempting login with username: $username');

  // Authenticate user
  bool isAuthenticated = await _userService.authenticateUser(username, password);

  if (!mounted) return;  // Ensure widget is mounted before using context

  if (isAuthenticated) {
    _logger.i('User authenticated successfully');
    
    // Navigate to the appropriate dashboard
    _navigateBasedOnRole(username);
  } else {
    _showError('Incorrect username or password');
  }
}

void _navigateBasedOnRole(String username) async {
  // Fetch user data from Hive
  UserModel? user = await UserService.getUser(username);
  if (user != null) {
    var box = await Hive.openBox('userBox');
    await box.put('role', user.role);
    String route = _getRouteForRole(user.role);

    // Log the route being navigated to
    _logger.i('Navigating to route: $route');

    // Navigate only if widget is still mounted
    if (mounted) {
      Future.delayed(Duration(milliseconds: 500), () {
        if (mounted) {
          Navigator.pushReplacementNamed(context, route);
        }
      });
    }
  } else {
    _showError('User not found');
  }
}

String _getRouteForRole(String role) {
  return {
    'admin': '/dashboard_admin',
    'lecturer': '/dashboard_lecturer',
    'student': '/student_dashboard',
  }[role] ?? '/not_found'; // Default to /not_found if role is unknown
}

  void _showError(String message) {
    // Display error message to the user
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Login Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Check if the route is set and navigate to it after the widget is built
    if (_nextRoute.isNotEmpty) {
      // Delay the navigation to ensure the widget is mounted and context is valid
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          Navigator.pushReplacementNamed(context, _nextRoute);
        }
      });
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _usernameController,
              focusNode: _usernameFocusNode,
              decoration: const InputDecoration(labelText: 'Username'),
            ),
            TextField(
              controller: _passwordController,
              focusNode: _passwordFocusNode,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _login,
              child: const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
