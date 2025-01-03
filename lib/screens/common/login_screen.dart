// screens/common/login_screen.dart
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../services/authentication_service.dart'; 

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final AuthenticationService _authenticationService = AuthenticationService(
    Hive.box('students'), 
    Hive.box('lecturers'), 
    Hive.box('admins')
  );

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    String username = _usernameController.text.trim();
    String password = _passwordController.text.trim();

    try {
      // Assuming role is passed and selected during login
      var result = await _authenticationService.login(
        identifier: username,
        password: password,
        role: 'student', // Change to dynamic based on the login role
      );
      var box = await Hive.openBox('userData');
      await box.put('role', result['role']); // Store role after successful login
      _navigateBasedOnRole(result['role']);
    } catch (e) {
      _showError('Login failed: ${e.toString()}');
    }
  }

  Future<void> _navigateBasedOnRole(String role) async {
    if (role == 'admin') {
      Navigator.pushReplacementNamed(context, '/dashboard_admin');
    } else if (role == 'lecturer') {
      Navigator.pushReplacementNamed(context, '/dashboard_lecturer');
    } else if (role == 'student') {
      Navigator.pushReplacementNamed(context, '/student_dashboard');
    } else {
      Navigator.pushReplacementNamed(context, '/error');
    }
  }

  void _showError(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Login Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(labelText: 'Username'),
            ),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
            ),
            ElevatedButton(
              onPressed: _login, // Login when button is pressed
              child: const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
