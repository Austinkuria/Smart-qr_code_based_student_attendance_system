import 'package:flutter/material.dart';


class DashboardLecturer extends StatelessWidget {
  const DashboardLecturer({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lecturer Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              Navigator.pushNamed(context, '/notifications_screen');
            },
            tooltip: 'Notifications',
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              Navigator.pushNamed(context, '/logout');
            },
            tooltip: 'Logout',
          ),
        ],
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
            GridView.count(
              crossAxisCount: MediaQuery.of(context).size.width > 600 ? 4 : 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
              children: [
                ActionCard(
                  icon: Icons.class_,
                  label: 'My Classes',
                  color: Colors.blue,
                  onTap: () {
                    Navigator.pushNamed(context, '/manage_classes');
                  },
                ),
                ActionCard(
                  icon: Icons.list_alt,
                  label: 'View Attendance',
                  color: Colors.green,
                  onTap: () {
                    Navigator.pushNamed(context, '/attendance_reports');
                  },
                ),
                ActionCard(
                  icon: Icons.qr_code,
                  label: 'Generate QR Code',
                  color: Colors.purple,
                  onTap: () {
                    Navigator.pushNamed(context, '/generate_qr_code_screen');
                  },
                ),
                ActionCard(
                  icon: Icons.person,
                  label: 'Update Profile',
                  color: Colors.orange,
                  onTap: () {
                    Navigator.pushNamed(context, '/update_profile');
                  },
                ),
                ActionCard(
                  icon: Icons.settings,
                  label: 'Settings',
                  color: Colors.grey,
                  onTap: () {
                    Navigator.pushNamed(context, '/settings_screen');
                  },
                ),
                ActionCard(
                  icon: Icons.notifications_active,
                  label: 'Notifications',
                  color: Colors.red,
                  onTap: () {
                    Navigator.pushNamed(context, '/notifications');
                  },
                ),
              ],
            ),
            const SizedBox(height: 30),

            // Recent Activities Section
            RecentActivities(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/schedule_class');
        },
        backgroundColor: Colors.blue,
        tooltip: 'Add Class',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class ActionCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const ActionCard({
    super.key,
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: color,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: Colors.white),
            const SizedBox(height: 10),
            Text(
              label,
              style: const TextStyle(color: Colors.white, fontSize: 16),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class RecentActivities extends StatelessWidget {
  const RecentActivities({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text(
          'Recent Activities',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        // Add your recent activities widgets here
      ],
    );
  }
}
