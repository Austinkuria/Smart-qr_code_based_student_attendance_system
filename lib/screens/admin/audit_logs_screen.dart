import 'package:flutter/material.dart';

class AuditLogsScreen extends StatelessWidget {
  const AuditLogsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Audit Logs'),
      ),
      body: Center(
        child: const Text('Audit Logs Screen'),
      ),
    );
  }
}