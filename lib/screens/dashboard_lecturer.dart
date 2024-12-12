import 'package:flutter/material.dart';

class DashboardLecturer extends StatelessWidget {
  const DashboardLecturer({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lecturer Dashboard'),
        backgroundColor: Colors.teal,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Welcome Section
            const Text(
              'Welcome, Lecturer!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            // Dashboard Options
            const Text(
              'Classroom Tools',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            GridView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              children: [
                _buildDashboardCard(
                  context,
                  icon: Icons.qr_code,
                  label: 'Generate QR Code',
                  onTap: () {
                    print('Generate QR Code Pressed');
                  },
                ),
                _buildDashboardCard(
                  context,
                  icon: Icons.history,
                  label: 'Attendance Records',
                  onTap: () {
                    print('Attendance Records Pressed');
                  },
                ),
                _buildDashboardCard(
                  context,
                  icon: Icons.class_,
                  label: 'Manage Classes',
                  onTap: () {
                    print('Manage Classes Pressed');
                  },
                ),
                _buildDashboardCard(
                  context,
                  icon: Icons.settings,
                  label: 'Settings',
                  onTap: () {
                    print('Settings Pressed');
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDashboardCard(BuildContext context,
      {required IconData icon, required String label, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 40, color: Colors.teal),
              const SizedBox(height: 10),
              Text(
                label,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
