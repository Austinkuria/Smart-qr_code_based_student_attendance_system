import 'package:intl/intl.dart';
import '../services/hive_service.dart';
import '../models/attendance.dart';


class AttendanceUtils {
  static Future<void> markAttendance(String sessionId, String studentId, String status) async {
    final hiveService = HiveService();
    final box = await hiveService.openAttendanceBox();
    final attendance = AttendanceModel(
      attendanceId: DateTime.now().millisecondsSinceEpoch.toString(),
      sessionId: sessionId,
      studentId: studentId,
      status: status,
      timestamp: DateTime.now(),
    );
    await box.add(attendance);
  }

  static Future<List<AttendanceModel>> getAttendanceForSession(String sessionId) async {
    final hiveService = HiveService();
    final box = await hiveService.openAttendanceBox();
    return box.values.where((attendance) => attendance.sessionId == sessionId).toList();
  }

  static String formatTimestamp(DateTime timestamp) {
    return DateFormat('yyyy-MM-dd HH:mm:ss').format(timestamp);
  }
}
