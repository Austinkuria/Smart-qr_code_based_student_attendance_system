import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../services/user_service.dart'; 

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final UserService _userService = UserService(); 

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    String username = _usernameController.text.trim();
    String password = _passwordController.text.trim();

    // Authenticate user
    bool isAuthenticated = await _userService.authenticateUser(username, password);

    if (!mounted) return; // Ensure widget is mounted before using context

    if (isAuthenticated) {
      // After successful authentication, store the role
      var user = await UserService.getUser(username); // Assuming getUser fetches user data
      if (user != null) {
        var box = await Hive.openBox('userData');
        await box.put('role', user.role); // Store role after successful login
      }
      // Navigate based on the stored role
      _navigateBasedOnRole();
    } else {
      // Handle authentication error
      _showError('Incorrect username or password');
    }
  }

  Future<void> _navigateBasedOnRole() async {
    var box = await Hive.openBox('userData');
    String role = box.get('role', defaultValue: 'lecturer'); // Default role if none is found

    // Navigate based on role
    if (!mounted) return; // Ensure widget is mounted before using context
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
              const Padding(
                padding: EdgeInsets.only(top: 20.0),
            ),
            ElevatedButton(
              onPressed: _login, // Login when button is pressed
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
              child: const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
