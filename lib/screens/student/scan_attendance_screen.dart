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
      } else {
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

      final sessionId = _extractSessionId(qrData);
      final studentId = _extractStudentId(qrData);
      final deviceId = await _getDeviceId();

      if (!mounted) return;

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
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
              ),
              child: IntrinsicHeight(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 4,
                      child: AspectRatio(
                        aspectRatio: 16 / 9,
                        child: Container(
                          color: Colors.black,
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
                      ),
                    ),
                    if (isScanning)
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: CircularProgressIndicator(),
                      ),
                    if (isError)
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'An error occurred while scanning. Please try again.',
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                    ElevatedButton(
                      onPressed: _resetScanner,
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
