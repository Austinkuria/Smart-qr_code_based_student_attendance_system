// lib/screens/login_screen.dart

import 'package:flutter/material.dart';
import '../models/user.dart';
import '../services/hive_service.dart';
import '../utils/security_utils.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final HiveService _hiveService = HiveService();

  void _login() async {
    String username = _usernameController.text.trim();
    String password = _passwordController.text.trim();

    UserModel? user = await _hiveService.getUser(username);

    if (user != null) {
      if (user.passwordHash == SecurityUtils.hashPassword(password)) {
        // Navigate to the appropriate dashboard based on user role
        switch (user.role) {
          case 'admin':
            Navigator.pushReplacementNamed(context, '/dashboard_admin');
            break;
          case 'lecturer':
            Navigator.pushReplacementNamed(context, '/dashboard_lecturer');
            break;
          case 'student':
            Navigator.pushReplacementNamed(context, '/dashboard_student');
            break;
          default:
            _showError('Invalid user role');
        }
      } else {
        _showError('Incorrect password');
      }
    } else {
      _showError('User not found');
    }
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
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16),
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