import 'package:hive/hive.dart';
import '../models/attendance_model.dart';
import 'package:logger/logger.dart';

class AttendanceService {
  final String _attendanceBox = 'attendanceBox';
  final Logger _logger = Logger();

  // Save attendance locally using Hive
  Future<void> saveAttendance(AttendanceModel attendance) async {
    _logger.i("Attendance saved locally: ${attendance.toJson()}");
    Logger().i("Attendance saved locally: ${attendance.toJson()}");
  }

  // Fetch all attendance records
  Future<List<AttendanceModel>> fetchAttendanceRecords() async {
    final box = await Hive.openBox<AttendanceModel>(_attendanceBox);
    return box.values.toList();
  }

  // Mark attendance with real data
  Future<void> markAttendance({
    required String studentId,
    required String sessionId,
    required String status,
    required String deviceId,
  }) async {
    final attendance = AttendanceModel(
      attendanceId: 'unique_${DateTime.now().millisecondsSinceEpoch}',
      sessionId: sessionId,
      studentId: studentId,
      status: status,
      timestamp: DateTime.now(),
      deviceId: deviceId,
    );

    final box = await Hive.openBox<AttendanceModel>(_attendanceBox);
    await box.put(attendance.attendanceId, attendance);
    _logger.i("Attendance marked for student $studentId in session $sessionId.");
  }
}
