import 'package:hive/hive.dart';
import '../models/attendance/qr_code_model.dart';

class QRCodeService {
  final Box<QRCode> _qrCodeBox;

  QRCodeService(this._qrCodeBox);

  // Create a new QR code
  Future<void> addQRCode(QRCode qrCode) async {
    if (_qrCodeBox.containsKey(qrCode.id)) {
      throw Exception('QR Code with ID ${qrCode.id} already exists.');
    }
    await _qrCodeBox.put(qrCode.id, qrCode);
  }

  // Read a QR code by ID
  QRCode? getQRCodeById(String id) {
    return _qrCodeBox.get(id);
  }

  // Update an existing QR code
  Future<void> updateQRCode(QRCode updatedQRCode) async {
    if (!_qrCodeBox.containsKey(updatedQRCode.id)) {
      throw Exception('QR Code with ID ${updatedQRCode.id} does not exist.');
    }
    await _qrCodeBox.put(updatedQRCode.id, updatedQRCode);
  }

  // Delete a QR code
  Future<void> deleteQRCode(String id) async {
    if (!_qrCodeBox.containsKey(id)) {
      throw Exception('QR Code with ID $id does not exist.');
    }
    await _qrCodeBox.delete(id);
  }

  // Fetch all QR codes
  List<QRCode> getAllQRCodes() {
    return _qrCodeBox.values.toList();
  }

  // Fetch QR codes by lecturer ID
  List<QRCode> getQRCodesByLecturer(String lecturerId) {
    return _qrCodeBox.values.where((qr) => qr.lecturerId == lecturerId).toList();
  }

  // Validate QR code expiration
  bool isQRCodeValid(String qrCodeId) {
    final qrCode = getQRCodeById(qrCodeId);
    if (qrCode == null) {
      throw Exception('QR Code with ID $qrCodeId does not exist.');
    }
    return DateTime.now().isBefore(qrCode.expiresAt);
  }
}
