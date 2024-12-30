import '../services/hive_service.dart';
import '../models/program_model.dart';

class ClassService {
  static Future<void> addClass(Class newClass) async {
    final hiveService = HiveService();
    final box = await hiveService.openClassBox();
    await box.add(newClass);
  }

  static Future<List<Class>> getClasses() async {
    final hiveService = HiveService();
    final box = await hiveService.openClassBox();
    return box.values.toList();
  }

  static Future<void> updateClass(Class updatedClass) async {
    final hiveService = HiveService();
    final box = await hiveService.openClassBox();
    final index = box.values.toList().indexWhere((classItem) => classItem.classId == updatedClass.classId);
    if (index != -1) {
      await box.putAt(index, updatedClass);
    }
  }

  static Future<void> deleteClass(String classId) async {
    final hiveService = HiveService();
    final box = await hiveService.openClassBox();
    final index = box.values.toList().indexWhere((classItem) => classItem.classId == classId);
    if (index != -1) {
      await box.deleteAt(index);
    }
  }
}
