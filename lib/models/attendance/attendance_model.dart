import 'package:hive/hive.dart';

part 'attendance_model.g.dart';

@HiveType(typeId: 5)
class Attendance {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String sessionId;

  @HiveField(2)
  final String studentId;

  @HiveField(3)
  final DateTime timestamp; 

  @HiveField(4)
  final String status;

  @HiveField(5)
  final DateTime createdAt; // New: Time when the attendance was created.

  @HiveField(6)
  final DateTime updatedAt; // New: Time when the attendance was last updated.

  Attendance({
    required this.id,
    required this.sessionId,
    required this.studentId,
    required this.timestamp,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'sessionId': sessionId,
      'studentId': studentId,
      'timestamp': timestamp.toIso8601String(),
      'status': status,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  factory Attendance.fromMap(Map<String, dynamic> map) {
    return Attendance(
      id: map['id'],
      sessionId: map['sessionId'],
      studentId: map['studentId'],
      timestamp: DateTime.parse(map['timestamp']),
      status: map['status'],
      createdAt: DateTime.parse(map['createdAt']),
      updatedAt: DateTime.parse(map['updatedAt']),
    );
  }
}
