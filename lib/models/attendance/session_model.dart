import 'package:hive/hive.dart';

part 'session_model.g.dart';

@HiveType(typeId: 4)
class Session {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String unitId;

  @HiveField(2)
  final String lecturerId;

  @HiveField(3)
  final DateTime startTime;

  @HiveField(4)
  final DateTime endTime;

  @HiveField(5)
  final String qrCodeData;

  @HiveField(6)
  final DateTime createdAt; // New: Time when the session was created.

  @HiveField(7)
  final DateTime updatedAt; // New: Time when the session was last updated.

  Session({
    required this.id,
    required this.unitId,
    required this.lecturerId,
    required this.startTime,
    required this.endTime,
    required this.qrCodeData,
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'unitId': unitId,
      'lecturerId': lecturerId,
      'startTime': startTime.toIso8601String(),
      'endTime': endTime.toIso8601String(),
      'qrCodeData': qrCodeData,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  factory Session.fromMap(Map<String, dynamic> map) {
    return Session(
      id: map['id'],
      unitId: map['unitId'],
      lecturerId: map['lecturerId'],
      startTime: DateTime.parse(map['startTime']),
      endTime: DateTime.parse(map['endTime']),
      qrCodeData: map['qrCodeData'],
      createdAt: DateTime.parse(map['createdAt']),
      updatedAt: DateTime.parse(map['updatedAt']),
    );
  }
}
