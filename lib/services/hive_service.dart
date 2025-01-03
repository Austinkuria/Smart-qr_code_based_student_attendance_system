// services/hive_service.dart
import 'package:hive/hive.dart';
import '../models/users/admin_model.dart';
import '../models/users/lecturer_model.dart';
import '../models/users/student_model.dart';

class HiveService {
  static Future<void> initializeHive() async {
    await Hive.initFlutter();
    Hive.registerAdapter(StudentAdapter());
    Hive.registerAdapter(LecturerAdapter());
    Hive.registerAdapter(AdminAdapter());
  }

  Future<void> initializeUsers() async {
    var studentBox = await Hive.openBox<Student>('students');
    var lecturerBox = await Hive.openBox<Lecturer>('lecturers');
    var adminBox = await Hive.openBox<Admin>('admins');
  }
}
