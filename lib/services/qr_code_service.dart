import '../services/hive_service.dart';
import '../models/qr_code.dart';


class QRCodeService {
  static Future<void> generateQRCode(String sessionId, String qrCodeData) async {
    final hiveService = HiveService();
    final box = await hiveService.openQRCodeBox();
    final qrCode = QRCode(
      qrCodeId: DateTime.now().millisecondsSinceEpoch.toString(),
      sessionId: sessionId,
      qrCodeData: qrCodeData,
      timestamp: DateTime.now(),
    );
    await box.add(qrCode);
  }

  static Future<List<QRCode>> getQRCodeBySession(String sessionId) async {
    final hiveService = HiveService();
    final box = await hiveService.openQRCodeBox();
    return box.values.where((qrCode) => qrCode.sessionId == sessionId).toList();
  }

  static Future<void> deleteQRCode(String qrCodeId) async {
    final hiveService = HiveService();
    final box = await hiveService.openQRCodeBox();
    await box.delete(qrCodeId);
  }
}
