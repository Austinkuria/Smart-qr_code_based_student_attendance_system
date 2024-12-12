import 'package:flutter/material.dart';

class ManageLecturersScreen extends StatelessWidget {
  const ManageLecturersScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manage Lecturers'),
      ),
      body: Center(
        child: Text('Lecturer management functionality goes here'),
      ),
    );
  }
}