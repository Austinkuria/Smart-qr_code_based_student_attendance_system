import '../models/attendance/attendance_model.dart';

class AnalyticsService {
  // Calculate attendance rate based on attendance records
  double calculateAttendanceRate(List<AttendanceRecord> records) {
    if (records.isEmpty) return 0.0;

    final totalSessions = records.length;
    final attendedSessions = records
        .where((record) => record.status == 'On-time' || record.status == 'Late')
        .length;

    return (attendedSessions / totalSessions) * 100;
  }
}
