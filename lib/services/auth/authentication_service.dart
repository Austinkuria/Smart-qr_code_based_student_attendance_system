import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hive/hive.dart';
import '../models/users/student_model.dart';
import '../models/users/lecturer_model.dart';
import '../models/users/admin_model.dart';
import '../utils/auth_errors.dart';
import '../utils/session_manager.dart';

class AuthenticationService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final Box<Student> _studentBox;
  final Box<Lecturer> _lecturerBox;
  final Box<Admin> _adminBox;

  AuthenticationService(this._studentBox, this._lecturerBox, this._adminBox);

  // Hashing function
  String _hashPassword(String password) {
    final bytes = utf8.encode(password); // Convert password to bytes
    final digest = sha256.convert(bytes); // Perform SHA-256 hashing
    return digest.toString(); // Return the hashed password as a string
  }

  Future<Map<String, dynamic>> login({
    required String identifier,
    required String password,
    required String role,
  }) async {
    try {
      // Hash the input password
      final hashedPassword = _hashPassword(password);

      switch (role.toLowerCase()) {
        case 'student':
          final student = _studentBox.values.firstWhere(
            (s) => s.registrationNumber == identifier && s.password == hashedPassword,
            orElse: () => throw AuthErrors.userNotFound(),
          );
          return {
            'role': 'student',
            'user': student,
          };

        case 'lecturer':
          final lecturer = _lecturerBox.values.firstWhere(
            (l) => l.email == identifier && l.password == hashedPassword,
            orElse: () => throw AuthErrors.userNotFound(),
          );
          return {
            'role': 'lecturer',
            'user': lecturer,
          };

        case 'admin':
          final admin = _adminBox.values.firstWhere(
            (a) => a.email == identifier && a.password == hashedPassword,
            orElse: () => throw AuthErrors.invalidCredentials(),
          );
          return {
            'role': 'admin',
            'user': admin,
          };

        default:
          throw AuthErrors.invalidRole();
      }
    } catch (e) {
      throw AuthErrors.loginFailed(e.toString());
    }
  }

  Future<void> register(String identifier, String password, String role) async {
    try {
      final hashedPassword = _hashPassword(password);

      switch (role.toLowerCase()) {
        case 'student':
          final newStudent = Student(registrationNumber: identifier, password: hashedPassword);
          _studentBox.add(newStudent);
          break;

        case 'lecturer':
          final newLecturer = Lecturer(email: identifier, password: hashedPassword);
          _lecturerBox.add(newLecturer);
          break;

        case 'admin':
          final newAdmin = Admin(email: identifier, password: hashedPassword);
          _adminBox.add(newAdmin);
          break;

        default:
          throw AuthErrors.invalidRole();
      }
    } catch (e) {
      throw AuthErrors.registrationFailed(e.toString());
    }
  }

  Future<void> logout() async {
    await _firebaseAuth.signOut();
    SessionManager.clearSession();
    print('User logged out successfully.');
  }
}
