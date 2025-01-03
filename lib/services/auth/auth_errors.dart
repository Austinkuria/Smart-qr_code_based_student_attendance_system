class AuthErrors {
  static Exception userNotFound() => Exception('User not found.');
  static Exception invalidCredentials() => Exception('Invalid credentials.');
  static Exception invalidRole() => Exception('Invalid role specified.');
  static Exception invalidAction() => Exception('Invalid action specified.');
  static Exception loginFailed(String message) => Exception('Login failed: $message');
  static Exception registrationFailed(String message) => Exception('Registration failed: $message');
}
