import 'package:flutter/material.dart';

class MyClassesScreen extends StatelessWidget {
  const MyClassesScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Classes'),
      ),
      body: Center(
        child: Text('My classes functionality will be implemented here.'),
      ),
    );
  }
}
