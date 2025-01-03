import 'package:hive/hive.dart';

class SessionManager {
  static void saveToken(String token) {
    Hive.box('session').put('token', token);
  }

  static String? getToken() {
    return Hive.box('session').get('token');
  }

  static void clearSession() {
    Hive.box('session').clear();
  }
}
