import 'package:flutter/material.dart';

class AttendanceReportsScreen extends StatelessWidget {
  const AttendanceReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Attendance Reports'),
      ),
      body: Center(
        child: const Text('Attendance Reports Screen'),
      ),
    );
  }
}