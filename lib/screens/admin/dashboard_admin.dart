import 'package:flutter/material.dart';

class DashboardAdmin extends StatelessWidget {
  const DashboardAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              // Navigate to Notifications Screen
              Navigator.pushNamed(context, '/notifications');
            },
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              // Handle logout
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Summary Cards
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                SummaryCard(
                  title: 'Total Classes',
                  count: '10',
                  icon: Icons.class_,
                  color: Colors.blue,
                ),
                SummaryCard(
                  title: 'Total Lecturers',
                  count: '25',
                  icon: Icons.person,
                  color: Colors.green,
                ),
                SummaryCard(
                  title: 'Total Students',
                  count: '200',
                  icon: Icons.school,
                  color: Colors.orange,
                ),
              ],
            ),
            const SizedBox(height: 30),

            // Action Grid
            GridView.count(
              crossAxisCount: MediaQuery.of(context).size.width > 600 ? 4 : 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
              children: [
                ActionCard(
                  icon: Icons.person_add,
                  label: 'Manage Lecturers',
                  color: Colors.purple,
                  onTap: () {
                    Navigator.pushNamed(context, '/manage_lecturers');
                  },
                ),
                ActionCard(
                  icon: Icons.class_,
                  label: 'Manage Classes',
                  color: Colors.blue,
                  onTap: () {
                    Navigator.pushNamed(context, '/manage_classes');
                  },
                ),
                ActionCard(
                  icon: Icons.person_add_alt_1,
                  label: 'Manage Students',
                  color: Colors.orange,
                  onTap: () {
                    Navigator.pushNamed(context, '/manage_students');
                  },
                ),
                ActionCard(
                  icon: Icons.settings,
                  label: 'Settings',
                  color: Colors.grey,
                  onTap: () {
                    Navigator.pushNamed(context, '/settings');
                  },
                ),
                ActionCard(
                  icon: Icons.analytics,
                  label: 'View Reports',
                  color: Colors.teal,
                  onTap: () {
                    Navigator.pushNamed(context, '/attendance_reports');
                  },
                ),
                ActionCard(
                  icon: Icons.help,
                  label: 'Help & Support',
                  color: Colors.red,
                  onTap: () {
                    Navigator.pushNamed(context, '/help_support_screen');
                  },
                ),
              ],
            ),
            const SizedBox(height: 30),

            // Recent Activities Section
            const RecentActivities(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Handle FAB action, e.g., adding a new admin or quick action
          Navigator.pushNamed(context, '/add_admin');
        },
        backgroundColor: Colors.teal,
        tooltip: 'Add Admin',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class SummaryCard extends StatelessWidget {
  final String title;
  final String count;
  final IconData icon;
  final Color color;

  const SummaryCard({
    required this.title,
    required this.count,
    required this.icon,
    required this.color,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        color: color.withAlpha((0.1 * 255).toInt()),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
        child: Padding(
          padding:
              const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
          child: Column(
            children: [
              Icon(icon, size: 40.0, color: color),
              const SizedBox(height: 10),
              Text(
                count,
                style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    color: color),
              ),
              const SizedBox(height: 5),
              Text(
                title,
                style: const TextStyle(fontSize: 16.0),
              ),
            ],
          ),
        ),
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
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(15.0),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 50.0, color: color),
              const SizedBox(height: 15.0),
              Text(
                label,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: color),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RecentActivities extends StatelessWidget {
  const RecentActivities({super.key});

  @override
  Widget build(BuildContext context) {
    // Sample recent activities data
    final List<String> activities = [
      'Added new lecturer: Dr. Jane Doe',
      'Updated attendance for Class 2',
      'Enrolled new student: John Smith',
      'Scheduled maintenance on 2023-10-05',
      'Removed lecturer: Mr. Mark Allen',
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Recent Activities',
          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: activities.length,
          itemBuilder: (context, index) {
            return Card(
              margin: const EdgeInsets.symmetric(vertical: 5.0),
              child: ListTile(
                leading: const Icon(Icons.check_circle, color: Colors.green),
                title: Text(activities[index]),
                trailing: const Icon(Icons.more_horiz),
              ),
            );
          },
        ),
      ],
    );
  }
}