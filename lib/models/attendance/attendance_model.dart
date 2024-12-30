import 'package:hive/hive.dart';

part 'attendance_model.g.dart';

@HiveType(typeId: 5)
class Attendance {
  @HiveField(0)
  final String id; // Unique attendance ID.

  @HiveField(1)
  final String sessionId; // ID of the session.

  @HiveField(2)
  final String studentId; // ID of the student.

  @HiveField(3)
  final DateTime timestamp; // Time when the attendance was marked.

  @HiveField(4)
  final String status; // Attendance status (e.g., "On-time", "Late", "Absent").

  Attendance({
    required this.id,
    required this.sessionId,
    required this.studentId,
    required this.timestamp,
    required this.status,
  });

  // Serialization
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'sessionId': sessionId,
      'studentId': studentId,
      'timestamp': timestamp.toIso8601String(),
      'status': status,
    };
  }

  factory Attendance.fromMap(Map<String, dynamic> map) {
    return Attendance(
      id: map['id'],
      sessionId: map['sessionId'],
      studentId: map['studentId'],
      timestamp: DateTime.parse(map['timestamp']),
      status: map['status'],
    );
  }
}
