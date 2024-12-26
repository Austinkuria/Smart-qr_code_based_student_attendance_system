import 'package:flutter/material.dart';
import 'package:flutter_web_qrcode_scanner/flutter_web_qrcode_scanner.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:logger/logger.dart';
import '../../services/attendance_service.dart';

class ScanAttendanceScreen extends StatefulWidget {
  const ScanAttendanceScreen({super.key});

  @override
  State<ScanAttendanceScreen> createState() => _ScanAttendanceScreenState();
}

class _ScanAttendanceScreenState extends State<ScanAttendanceScreen> {
  final Logger logger = Logger();
  bool isScanning = true;
  bool isError = false;

  @override
  void initState() {
    super.initState();
    logger.i('Initializing ScanAttendanceScreen');
  }

  void _resetScanner() {
    setState(() {
      isScanning = true;
      isError = false;
    });
  }

  Future<String> _getDeviceId() async {
    try {
      final deviceInfo = DeviceInfoPlugin();
      if (Theme.of(context).platform == TargetPlatform.android) {
        final androidInfo = await deviceInfo.androidInfo;
        return androidInfo.id; 
      } else if (Theme.of(context).platform == TargetPlatform.iOS) {
        final iosInfo = await deviceInfo.iosInfo;
        return iosInfo.identifierForVendor ?? 'UnknownDevice';
      } else if (Theme.of(context).platform == TargetPlatform.fuchsia ||
          Theme.of(context).platform == TargetPlatform.linux ||
          Theme.of(context).platform == TargetPlatform.macOS ||
          Theme.of(context).platform == TargetPlatform.windows) {
        return 'DesktopDevice';
      } else {
        // Web fallback
        return 'WebDevice_${DateTime.now().millisecondsSinceEpoch}';
      }
    } catch (error) {
      logger.e('Error fetching device ID: $error');
      return 'UnknownDevice';
    }
  }

  Future<void> _handleScan(String qrData) async {
    try {
      logger.i('QR Code Scanned: $qrData');
      
      // Extract session and student IDs
      final sessionId = _extractSessionId(qrData);
      final studentId = _extractStudentId(qrData);
      
      // Get device ID
      final deviceId = await _getDeviceId();

      if (!mounted) return; // Check if widget is still mounted

      // Mark attendance
      await AttendanceService().markAttendance(
        studentId: studentId,
        sessionId: sessionId,
        status: 'Present',
        deviceId: deviceId,
      );

      if (mounted) {
        setState(() {
          isScanning = false;
          isError = false;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Attendance marked successfully!')),
        );
      }
    } catch (error) {
      logger.e('Error processing QR code: $error');
      if (mounted) {
        setState(() {
          isScanning = false;
          isError = true;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Error marking attendance.')),
        );
      }
    }
  }

  String _extractSessionId(String qrData) {
    try {
      final dataParts = qrData.split(';');
      return dataParts
          .firstWhere((part) => part.startsWith('sessionId='))
          .split('=')[1];
    } catch (e) {
      throw FormatException('Invalid QR data format: Missing sessionId');
    }
  }

  String _extractStudentId(String qrData) {
    try {
      final dataParts = qrData.split(';');
      return dataParts
          .firstWhere((part) => part.startsWith('studentId='))
          .split('=')[1];
    } catch (e) {
      throw FormatException('Invalid QR data format: Missing studentId');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scan Attendance'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: 4,
            child: FlutterWebQrcodeScanner(
              cameraDirection: CameraDirection.back,
              onGetResult: _handleScan,
              stopOnFirstResult: true,
              onError: (error) {
                logger.e('QR Code Scanner Error: ${error.message}');
                setState(() {
                  isScanning = false;
                  isError = true;
                });
              },
            ),
          ),
          if (isError)
            const Text(
              'An error occurred while scanning. Please try again.',
              style: TextStyle(color: Colors.red),
            ),
          ElevatedButton(
            onPressed: _resetScanner,
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }
}
