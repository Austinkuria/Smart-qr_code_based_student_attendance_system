import 'package:hive/hive.dart';

part 'session.g.dart';

@HiveType(typeId: 6)
class Session {
  @HiveField(0)
  final String sessionId;

  @HiveField(1)
  final String classId;

  @HiveField(2)
  final DateTime startTime;

  @HiveField(3)
  final DateTime endTime;

  @HiveField(4)
  final String? qrCode; // Optional QR code data

  @HiveField(5)
  final String? status; // Optional status of the session (e.g., "Scheduled", "Completed")

  Session({
    required this.sessionId,
    required this.classId,
    required this.startTime,
    required this.endTime,
    this.qrCode,
    this.status,
  });

  Map<String, dynamic> toJson() {
    return {
      'sessionId': sessionId,
      'classId': classId,
      'startTime': startTime.toIso8601String(),
      'endTime': endTime.toIso8601String(),
      'qrCode': qrCode,
      'status': status,
    };
  }

  factory Session.fromJson(Map<String, dynamic> json) {
    return Session(
      sessionId: json['sessionId'],
      classId: json['classId'],
      startTime: DateTime.parse(json['startTime']),
      endTime: DateTime.parse(json['endTime']),
      qrCode: json['qrCode'],
      status: json['status'],
    );
  }
}
