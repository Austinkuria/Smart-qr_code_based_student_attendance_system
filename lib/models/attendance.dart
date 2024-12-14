import 'package:hive/hive.dart';

part 'attendance.g.dart';

@HiveType(typeId: 1)
class AttendanceModel extends HiveObject {
  @HiveField(0)
  final String attendanceId;

  @HiveField(1)
  final String sessionId;

  @HiveField(2)
  final String studentId;

  @HiveField(3)
  final String status; // e.g., Present, Late, Absent

  @HiveField(4)
  final DateTime timestamp;

  @HiveField(5)
  final String? deviceId; // Optional device ID

  @HiveField(6)
  final String? location; // Optional location

  AttendanceModel({
    required this.attendanceId,
    required this.sessionId,
    required this.studentId,
    required this.status,
    required this.timestamp,
    this.deviceId,
    this.location,
  });

  Map<String, dynamic> toJson() {
    return {
      'attendanceId': attendanceId,
      'sessionId': sessionId,
      'studentId': studentId,
      'status': status,
      'timestamp': timestamp.toIso8601String(),
      'deviceId': deviceId,
      'location': location,
    };
  }

  factory AttendanceModel.fromJson(Map<String, dynamic> json) {
    return AttendanceModel(
      attendanceId: json['attendanceId'],
      sessionId: json['sessionId'],
      studentId: json['studentId'],
      status: json['status'],
      timestamp: DateTime.parse(json['timestamp']),
      deviceId: json['deviceId'],
      location: json['location'],
    );
  }
}
