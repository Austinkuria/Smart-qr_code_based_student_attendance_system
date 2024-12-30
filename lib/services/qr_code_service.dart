import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../models/qr_code_model.dart'; 
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
    // Generate QR code data in key-value pair format
    return "sessionId=$sessionId";
  }

  // Method to save QR code data
  Future<void> saveQRCode(QRCode qrCode) async {
    final hiveService = HiveService();  // HiveService for handling Hive operations
    await hiveService.saveQRCode(qrCode); // Save the QR code using Hive
  }
}
