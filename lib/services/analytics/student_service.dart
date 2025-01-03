import 'analytics_service.dart';
import '../models/attendance/attendance_model.dart';

class StudentAnalyticsService extends AnalyticsService {
  // Get attendance rate for a student across all semesters
  double getOverallAttendanceRate(
      String studentId, List<AttendanceRecord> records) {
    final studentRecords =
        records.where((record) => record.studentId == studentId).toList();
    return calculateAttendanceRate(studentRecords);
  }

  // Get attendance rate for a specific semester
  double getSemesterAttendanceRate(String studentId, String semesterId,
      List<AttendanceRecord> records) {
    final semesterRecords = records
        .where((record) =>
            record.studentId == studentId && record.semesterId == semesterId)
        .toList();
    return calculateAttendanceRate(semesterRecords);
  }

  // Get attendance rate for a specific unit
  double getUnitAttendanceRate(
      String studentId, String unitId, List<AttendanceRecord> records) {
    final unitRecords = records
        .where(
            (record) => record.studentId == studentId && record.unitId == unitId)
        .toList();
    return calculateAttendanceRate(unitRecords);
  }
}
