import '../models/user.dart';
import '../services/hive_service.dart';
import 'package:logger/logger.dart';
import '../utils/security_utils.dart';

class UserService {
  // Fetch user details from Hive storage
  static Future<UserModel?> getUser(String username) async {
  final box = await HiveService.openUserBox(); // Open the user box
  try {
    for (var user in box.values) {
      if (user.username == username) {
        return user;
      }
    }
    return null; // No match found
  } catch (e) {
    Logger().e("Error fetching user: $e");
    return null;
  }
}

  // Example function for user login
  Future<bool> authenticateUser(String username, String password) async {
    UserModel? user = await getUser(username);
    if (user != null) {
      // Use SecurityUtils to validate the password
      if (SecurityUtils.validatePassword(password, user.passwordHash)) {
        return true; // User authenticated
      }
    }
    return false; // Invalid username or password
  }
}
