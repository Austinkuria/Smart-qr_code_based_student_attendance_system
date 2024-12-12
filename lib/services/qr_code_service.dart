// import 'package:logger/logger.dart';
// import 'package:qr_flutter/qr_flutter.dart';
// import 'package:flutter/material.dart';
// import 'package:qr_code_scanner/qr_code_scanner.dart';

// class QRCodeService {
//   static final Logger logger = Logger();

//   static Future<String?> scanQRCode(QRViewController controller) async {
//     try {
//       final scanData = await controller.scannedDataStream.first;
//       return scanData.code;  // Return scanned data (studentId, sessionId, etc.)
//     } catch (e) {
//       logger.e('Error scanning QR code: $e');
//       return null;
//     }
//   }

//   static Widget generateQRCode(String data) {
//     // Logic to generate QR code from data
//     return QrImage(
//       data: data,
//       version: QrVersions.auto,
//       size: 200.0,
//     );
//   }
// }