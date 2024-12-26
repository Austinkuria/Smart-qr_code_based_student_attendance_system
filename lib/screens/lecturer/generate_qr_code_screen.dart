import 'package:flutter/material.dart';
import '../../services/qr_code_service.dart';
import 'package:logger/logger.dart';
import '../../models/qr_code.dart';

class GenerateQRCodeScreen extends StatefulWidget {
  const GenerateQRCodeScreen({super.key});

  @override
  State<GenerateQRCodeScreen> createState() => _GenerateQRCodeScreenState();
}

class _GenerateQRCodeScreenState extends State<GenerateQRCodeScreen> {
  String? _qrData;
  bool _isGenerated = false;
  bool _isLoading = false; // Loading state
  final Logger logger = Logger();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Generate QR Code'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_isLoading)
              const CircularProgressIndicator(), // Show loader during generation
            if (_isGenerated && _qrData != null && !_isLoading)
              QRCodeService().generateQRCode(_qrData!, 200.0),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _isLoading ? null : _generateQRCode, // Disable button during loading
              child: const Text('Generate QR Code'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _generateQRCode() async {
    setState(() {
      _isLoading = true; // Set loading state
    });

    try {
      final qrCodeService = QRCodeService();
      final sessionId = "session_${DateTime.now().millisecondsSinceEpoch}";
      final qrData = await qrCodeService.createQRCodeData(sessionId);

      setState(() {
        _qrData = qrData;
        _isGenerated = true;
        _isLoading = false; // Reset loading state
      });

      // Save QR Code to Hive storage
      await qrCodeService.saveQRCode(
        QRCode(
          qrCodeId: 'qr_${DateTime.now().millisecondsSinceEpoch}',
          sessionId: sessionId,
          qrCodeData: qrData,
          timestamp: DateTime.now(),
        ),
      );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('QR Code generated successfully!')),
        );
      }
    } catch (error) {
      logger.e('Error generating QR code: $error');
      setState(() {
        _isLoading = false; // Reset loading state
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $error')),
        );
      }
    }
  }
}
