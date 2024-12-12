// lib/services/hive_service.dart

import 'package:hive/hive.dart';
import '../models/user.dart';
import '../utils/security_utils.dart';

class HiveService {
  static const String userBoxName = 'users';

  Future<Box<UserModel>> _openUserBox() async {
    return await Hive.openBox<UserModel>(userBoxName);
  }

  Future<UserModel?> getUser(String username) async {
    var box = await _openUserBox();
    return box.get(username);
  }

  Future<void> addUser(UserModel user) async {
    var box = await _openUserBox();
    await box.put(user.username, user);
  }

  Future<void> initializeUsers() async {
    var box = await _openUserBox();
    if (box.isEmpty) {
      // Add initial admin user
      await addUser(UserModel(
        username: 'admin',
        passwordHash: SecurityUtils.hashPassword('admin123'),
        role: 'admin',
      ));
      // Add initial lecturer user
      await addUser(UserModel(
        username: 'lecturer1',
        passwordHash: SecurityUtils.hashPassword('lecturer123'),
        role: 'lecturer',
      ));
      // Add initial student user
      await addUser(UserModel(
        username: 'student1',
        passwordHash: SecurityUtils.hashPassword('student123'),
        role: 'student',
      ));
    }
  }
}