import 'package:flutter/material.dart';

class ScanAttendanceScreen extends StatelessWidget {
  const ScanAttendanceScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scan Attendance'),
      ),
      body: Center(
        child: Text('Attendance scanning functionality will be implemented here.'),
      ),
    );
  }
}
