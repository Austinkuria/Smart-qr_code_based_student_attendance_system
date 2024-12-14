import 'package:hive/hive.dart';

part 'qr_code.g.dart';

@HiveType(typeId: 5)
class QRCode {
  @HiveField(0)
  final String qrCodeId;

  @HiveField(1)
  final String sessionId;

  @HiveField(2)
  final String qrCodeData; // Encoded string

  @HiveField(3)
  final DateTime timestamp;

  QRCode({
    required this.qrCodeId,
    required this.sessionId,
    required this.qrCodeData,
    required this.timestamp,
  });
}
