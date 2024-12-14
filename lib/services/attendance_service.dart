import '../services/hive_service.dart';
import '../models/attendance.dart';


class AttendanceService {
  static Future<void> addAttendance(AttendanceModel attendance) async {
    final hiveService = HiveService();
    final box = await hiveService.openAttendanceBox();
    await box.add(attendance);
  }

  static Future<List<AttendanceModel>> getAttendanceBySession(String sessionId) async {
    final hiveService = HiveService();
    final box = await hiveService.openAttendanceBox();
    return box.values.where((attendance) => attendance.sessionId == sessionId).toList();
  }

  static Future<void> updateAttendance(AttendanceModel updatedAttendance) async {
    final hiveService = HiveService();
    final box = await hiveService.openAttendanceBox();
    final index = box.values.toList().indexWhere((attendance) => attendance.attendanceId == updatedAttendance.attendanceId);
    if (index != -1) {
      await box.putAt(index, updatedAttendance);
    }
  }

  static Future<void> deleteAttendance(String attendanceId) async {
    final hiveService = HiveService();
    final box = await hiveService.openAttendanceBox();
    final index = box.values.toList().indexWhere((attendance) => attendance.attendanceId == attendanceId);
    if (index != -1) {
      await box.deleteAt(index);
    }
  }
}
