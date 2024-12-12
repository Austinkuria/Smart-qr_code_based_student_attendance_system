// import 'package:flutter/material.dart';
// import 'package:qr_code_scanner/qr_code_scanner.dart';
// import 'package:logger/logger.dart';

// class ScannerScreen extends StatefulWidget {
//   const ScannerScreen({super.key});

//   @override
//   ScannerScreenState createState() => ScannerScreenState();
// }

// class ScannerScreenState extends State<ScannerScreen> {
//   final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
//   QRViewController? controller;
//   final Logger logger = Logger();

//   @override
//   void reassemble() {
//     super.reassemble();
//     if (controller != null) {
//       controller!.pauseCamera();
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('QR Code Scanner')),
//       body: QRView(
//         key: qrKey,
//         onQRViewCreated: (QRViewController controller) {
//           this.controller = controller;
//           controller.scannedDataStream.listen((scanData) {
//             logger.i('Scanned QR Code: ${scanData.code}');
//           });
//         },
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     controller?.dispose();
//     super.dispose();
//   }
// }