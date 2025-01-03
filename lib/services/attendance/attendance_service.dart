import 'package:hive/hive.dart';
import '../models/attendance_model.dart';

class AttendanceService {
  final Box<Attendance> _attendanceBox;

  AttendanceService(this._attendanceBox);

  // Create new attendance
  Future<void> addAttendance(Attendance attendance) async {
    if (_attendanceBox.containsKey(attendance.id)) {
      throw Exception('Attendance with ID ${attendance.id} already exists.');
    }
    await _attendanceBox.put(attendance.id, attendance);
  }

  // Read attendance by ID
  Attendance? getAttendanceById(String id) {
    return _attendanceBox.get(id);
  }

  // Update existing attendance
  Future<void> updateAttendance(Attendance updatedAttendance) async {
    if (!_attendanceBox.containsKey(updatedAttendance.id)) {
      throw Exception('Attendance with ID ${updatedAttendance.id} does not exist.');
    }
    await _attendanceBox.put(updatedAttendance.id, updatedAttendance);
  }

  // Delete attendance by ID
  Future<void> deleteAttendance(String id) async {
    if (!_attendanceBox.containsKey(id)) {
      throw Exception('Attendance with ID $id does not exist.');
    }
    await _attendanceBox.delete(id);
  }

  // Fetch all attendance records
  List<Attendance> getAllAttendance() {
    return _attendanceBox.values.toList();
  }

  // Fetch attendance records by session ID
  List<Attendance> getAttendanceBySession(String sessionId) {
    return _attendanceBox.values.where((att) => att.sessionId == sessionId).toList();
  }

  // Fetch attendance records by student ID
  List<Attendance> getAttendanceByStudent(String studentId) {
    return _attendanceBox.values.where((att) => att.studentId == studentId).toList();
  }

  // Mark attendance status
  Future<void> markAttendanceStatus(String attendanceId, String status) async {
    final attendance = getAttendanceById(attendanceId);
    if (attendance == null) {
      throw Exception('Attendance with ID $attendanceId does not exist.');
    }
    final updatedAttendance = Attendance(
      id: attendance.id,
      sessionId: attendance.sessionId,
      studentId: attendance.studentId,
      timestamp: attendance.timestamp,
      status: status,
      createdAt: attendance.createdAt,
      updatedAt: DateTime.now(),
    );
    await updateAttendance(updatedAttendance);
  }
}
