import 'package:flutter/material.dart';
import 'authentication_service.dart';

class AuthProvider extends ChangeNotifier {
  final AuthenticationService _authService;

  bool _isAuthenticated = false;
  String? _role;
  dynamic _user;

  AuthProvider(this._authService);

  bool get isAuthenticated => _isAuthenticated;
  String? get role => _role;
  dynamic get user => _user;

  Future<void> login(String identifier, String password, String role) async {
    try {
      final result = await _authService.login(
        identifier: identifier,
        password: password,
        role: role,
      );
      _isAuthenticated = true;
      _role = result['role'];
      _user = result['user'];
      notifyListeners();
    } catch (e) {
      _isAuthenticated = false;
      throw e;
    }
  }

  Future<void> logout() async {
    await _authService.logout();
    _isAuthenticated = false;
    _role = null;
    _user = null;
    notifyListeners();
  }
}
