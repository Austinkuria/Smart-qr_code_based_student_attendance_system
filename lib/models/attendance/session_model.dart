import 'package:hive/hive.dart';

part 'session_model.g.dart';

@HiveType(typeId: 4)
class Session {
  @HiveField(0)
  final String id; // Unique session ID.

  @HiveField(1)
  final String unitId; // ID of the unit the session belongs to.

  @HiveField(2)
  final String lecturerId; // ID of the lecturer conducting the session.

  @HiveField(3)
  final DateTime startTime; // Start time of the session.

  @HiveField(4)
  final DateTime endTime; // End time of the session.

  @HiveField(5)
  final String qrCodeData; // QR code data for the session.

  Session({
    required this.id,
    required this.unitId,
    required this.lecturerId,
    required this.startTime,
    required this.endTime,
    required this.qrCodeData,
  });

  // Serialization
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'unitId': unitId,
      'lecturerId': lecturerId,
      'startTime': startTime.toIso8601String(),
      'endTime': endTime.toIso8601String(),
      'qrCodeData': qrCodeData,
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
    );
  }
}
