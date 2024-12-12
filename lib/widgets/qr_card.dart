import 'package:flutter/material.dart';

class QRCard extends StatelessWidget {
  final String qrData;

  const QRCard({super.key, required this.qrData});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text('QR Data: $qrData'),
      ),
    );
  }
}
