import 'package:flutter/material.dart';
import 'package:flutter_web_qrcode_scanner/flutter_web_qrcode_scanner.dart';
import 'package:logger/logger.dart';

class ScanAttendanceScreen extends StatefulWidget {
  const ScanAttendanceScreen({super.key});

  @override
  State<ScanAttendanceScreen> createState() => _ScanAttendanceScreenState();
}

class _ScanAttendanceScreenState extends State<ScanAttendanceScreen> {
  final Logger logger = Logger();
  String? scannedData;
  bool isScanning = true;
  bool isError = false;

  @override
  void initState() {
    super.initState();
    logger.i('Initializing ScanAttendanceScreen');
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
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 4,
            child: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blueAccent, width: 2),
                borderRadius: BorderRadius.circular(10),
              ),
              child: FlutterWebQrcodeScanner(
                cameraDirection: CameraDirection.back,
                onGetResult: (result) {
                  setState(() {
                    scannedData = result;
                    isScanning = false;
                    isError = false;
                    logger.i('QR Code Scanned: $scannedData');
                  });
                },
                stopOnFirstResult: true,
                width: MediaQuery.of(context).size.width * 0.8,
                height: MediaQuery.of(context).size.height * 0.8,
                onError: (error) {
                  setState(() {
                    isError = true;
                    isScanning = false;
                  });
                  logger.e('QR Code Scanner Error: ${error.message}');
                },
                onPermissionDeniedError: () {
                  setState(() {
                    isScanning = false;
                    isError = true;
                  });
                  logger.e('Camera permission denied');
                  // Show an alert dialog or some other UI to inform the user
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Permission Denied'),
                      content: const Text('Camera permission is required to scan QR codes.'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: const Text('OK'),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: isScanning
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const CircularProgressIndicator(
                          color: Colors.blueAccent,
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          'Scanning... Please hold your camera steady.',
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    )
                  : isError
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.error,
                              color: Colors.red,
                              size: 40,
                            ),
                            const SizedBox(height: 10),
                            const Text(
                              'An error occurred or permission denied. Try again!',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 16, color: Colors.red),
                            ),
                          ],
                        )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Scanned Data:',
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              scannedData!,

                              textAlign: TextAlign.center,
                              style: const TextStyle(fontSize: 14),
                            ),
                            const SizedBox(height: 20),
                            ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  isScanning = true;
                                  scannedData = null;
                                });
                              },
                              style: ElevatedButton.styleFrom(backgroundColor: Colors.blueAccent),
                              child: const Text('Scan Again'),
                            ),
                          ],
                        ),
            ),
          ),
        ],
      ),
    );
  }
}
