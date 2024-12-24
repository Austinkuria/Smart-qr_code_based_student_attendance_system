import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'scan_attendance_screen.dart'; 

class DashboardStudent extends StatelessWidget {
  final Logger logger = Logger();

  DashboardStudent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Dashboard'),
        backgroundColor: Colors.blueAccent,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Welcome Section
            const Text(
              'Welcome, Student!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            // Profile Section
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListTile(
                leading: const CircleAvatar(
                  backgroundImage: AssetImage('assets/student_avatar.png'), // Placeholder for profile image
                ),
                title: const Text('John Doe'),
                subtitle: const Text('ID: 123456'),
                trailing: IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    logger.i('Edit Profile Pressed');
                  },
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Dashboard Options
            const Text(
              'Dashboard Options',
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
                  icon: Icons.qr_code_scanner,
                  label: 'Scan Attendance',
                  onTap: () {
                    logger.i('Navigating to Scan Attendance Screen');
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const ScanAttendanceScreen()),
                    );
                  },
                ),
                _buildDashboardCard(
                  context,
                  icon: Icons.history,
                  label: 'Attendance Records',
                  onTap: () {
                    logger.i('Navigating to Attendance Records Screen');
                    // Add your navigation logic here
                  },
                ),
                _buildDashboardCard(
                  context,
                  icon: Icons.settings,
                  label: 'Settings',
                  onTap: () {
                    logger.i('Navigating to Settings Screen');
                    // Add your navigation logic here
                  },
                ),
                _buildDashboardCard(
                  context,
                  icon: Icons.help_outline,
                  label: 'Help',
                  onTap: () {
                    logger.i('Navigating to Help Screen');
                    // Add your navigation logic here
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Helper method to build dashboard cards
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
              Icon(icon, size: 40, color: Colors.blueAccent),
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
