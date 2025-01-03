import 'analytics_service.dart';
import '../models/attendance/attendance_model.dart';
import '../models/academic/unit_model.dart';

class LecturerAnalyticsService extends AnalyticsService {
  // Get attendance rates for all units taught by a lecturer
  Map<String, double> getUnitAttendanceRates(
      String lecturerId, List<Unit> units, List<AttendanceRecord> records) {
    final unitRates = <String, double>{};

    for (var unit in units.where((unit) => unit.id == lecturerId)) {
      final unitRecords =
          records.where((record) => record.unitId == unit.id).toList();
      unitRates[unit.name] = calculateAttendanceRate(unitRecords);
    }

    return unitRates;
  }

  // Get attendance rates for a specific unit
  double getSpecificUnitAttendanceRate(
      String unitId, List<AttendanceRecord> records) {
    final unitRecords =
        records.where((record) => record.unitId == unitId).toList();
    return calculateAttendanceRate(unitRecords);
  }
}
