import 'package:hive/hive.dart';

part 'qr_code_model.g.dart';

@HiveType(typeId: 10)
class QRCode {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String lecturerId;

  @HiveField(2)
  final String programId;

  @HiveField(3)
  final String unitId;

  @HiveField(4)
  final DateTime generatedAt;

  @HiveField(5)
  final DateTime expiresAt;

  @HiveField(6)
  final DateTime createdAt; // New: Time when the QR code was created.

  @HiveField(7)
  final DateTime updatedAt; // New: Time when the QR code was last updated.

  QRCode({
    required this.id,
    required this.lecturerId,
    required this.programId,
    required this.unitId,
    required this.generatedAt,
    required this.expiresAt,
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'lecturerId': lecturerId,
      'programId': programId,
      'unitId': unitId,
      'generatedAt': generatedAt.toIso8601String(),
      'expiresAt': expiresAt.toIso8601String(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  factory QRCode.fromMap(Map<String, dynamic> map) {
    return QRCode(
      id: map['id'],
      lecturerId: map['lecturerId'],
      programId: map['programId'],
      unitId: map['unitId'],
      generatedAt: DateTime.parse(map['generatedAt']),
      expiresAt: DateTime.parse(map['expiresAt']),
      createdAt: DateTime.parse(map['createdAt']),
      updatedAt: DateTime.parse(map['updatedAt']),
    );
  }
}
