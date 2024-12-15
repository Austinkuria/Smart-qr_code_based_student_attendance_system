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
              // Navigate to Notifications Screen
              Navigator.pushNamed(context, '/notifications_screen');
            },
            tooltip: 'Notifications',
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              // Handle logout
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
                ActionCard(
                  icon: Icons.feedback_outlined,
                  label: 'Feedback',
                  color: Colors.teal,
                  onTap: () {
                    Navigator.pushNamed(context, '/student_feedback');
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
          // Handle FAB action, e.g., adding a new class
          Navigator.pushNamed(context, '/schedule_class');
        },
        backgroundColor: Colors.blue,
        tooltip: 'Add Class',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class ActionCard extends StatefulWidget {
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
  State<ActionCard> createState() => _ActionCardState();
}

class _ActionCardState extends State<ActionCard> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _animation = Tween<double>(begin: 1.0, end: 1.05).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _animation,
      child: Card(
        elevation: 4.0,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
        child: InkWell(
          onTap: () {
            widget.onTap();
          },
          borderRadius: BorderRadius.circular(15.0),
          onTapDown: (_) {
            _controller.forward();
          },
          onTapUp: (_) {
            _controller.reverse();
          },
          onTapCancel: () {
            _controller.reverse();
          },
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(widget.icon, size: 50.0, color: widget.color),
                const SizedBox(height: 15.0),
                Text(
                  widget.label,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: widget.color),
                ),
              ],
            ),
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
      'Added a new class: Physics 101',
      'Updated attendance for Chemistry 201',
      'Enrolled new student: Alice Johnson',
      'Edited profile information',
      'Scheduled office hours for Mathematics 301',
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