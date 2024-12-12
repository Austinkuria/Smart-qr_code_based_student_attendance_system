import 'package:flutter/material.dart';
// import '../models/user.dart';

class DashboardAdmin extends StatefulWidget {
  const DashboardAdmin({super.key});

  @override
  DashboardAdminState createState() => DashboardAdminState();
}

class DashboardAdminState extends State<DashboardAdmin> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Dashboard'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              // Navigate back to the login screen
              Navigator.pushReplacementNamed(context, '/');
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            ElevatedButton.icon(
              icon: Icon(Icons.person_add),
              label: Text('Manage Lecturers'),
              onPressed: () {
                // Navigate to the manage lecturers screen
                Navigator.pushNamed(context, '/manage_lecturers');
              },
            ),
            SizedBox(height: 20),
            ElevatedButton.icon(
              icon: Icon(Icons.person_add_alt_1),
              label: Text('Manage Students'),
              onPressed: () {
                // Navigate to the manage students screen
                Navigator.pushNamed(context, '/manage_students');
              },
            ),
            SizedBox(height: 20),
            ElevatedButton.icon(
              icon: Icon(Icons.analytics),
              label: Text('View Attendance Reports'),
              onPressed: () {
                // Navigate to the attendance reports screen
                Navigator.pushNamed(context, '/attendance_reports');
              },
            ),
          ],
        ),
      ),
    );
  }
}