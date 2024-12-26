import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../models/qr_code.dart'; // Ensure this path matches your project structure
import '../services/hive_service.dart'; // Import your Hive service for data persistence

class QRCodeService {
  // Method to generate QR code widget
  Widget generateQRCode(String data, double size) {
    return QrImageView(
      data: data, // QR code data
      version: QrVersions.auto, // Automatically adjust the version
      size: size, // QR code size
      gapless: false, // Whether to include gaps
      errorStateBuilder: (context, error) {
        return Center(
          child: Text(
            'Error generating QR code',
            style: TextStyle(color: Colors.red),
          ),
        );
      },
    );
  }

  // Method to create QR code data
  Future<String> createQRCodeData(String sessionId) async {
    // Generate QR code data based on sessionId or other inputs
    return "qr_data_for_$sessionId";
  }

  // Method to save QR code data
  Future<void> saveQRCode(QRCode qrCode) async {
    final hiveService = HiveService(); // Assuming you have a HiveService for handling Hive operations
    await hiveService.saveQRCode(qrCode); // Save the QR code using Hive
  }
}
