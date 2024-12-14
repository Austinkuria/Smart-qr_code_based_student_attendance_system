import 'package:crypto/crypto.dart';
import 'dart:convert';

class SecurityUtils {
  // Method to hash a password using SHA-256
  static String hashPassword(String password) {
    var bytes = utf8.encode(password); // Convert password to bytes
    var hash = sha256.convert(bytes); // Generate SHA-256 hash
    return hash.toString(); // Return the hash as a string
  }

  // Method to validate a password against a stored hash
  static bool validatePassword(String password, String storedHash) {
    var hashedPassword = hashPassword(password);
    return hashedPassword == storedHash; // Check if the hash matches
  }

  // Method to generate a secure random string (e.g., for tokens or salts)
  static String generateRandomString(int length) {
    const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
    var rand = List.generate(length, (index) {
      var randomIndex = DateTime.now().millisecondsSinceEpoch % chars.length;
      return chars[randomIndex];
    }).join();
    return rand;
  }
}
