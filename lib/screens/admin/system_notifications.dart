import 'package:flutter/material.dart';

class SystemNotificationsScreen extends StatelessWidget {
  const SystemNotificationsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('System Notifications'),
      ),
      body: Center(
        child: const Text('System notifications functionality will be implemented here.'),
      ),
    );
  }
}
