import 'package:flutter/material.dart';

class ManageClassesScreen extends StatelessWidget {
  const ManageClassesScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manage Classes'),
      ),
      body: Center(
        child: Text('Class management functionality goes here'),
      ),
    );
  }
}