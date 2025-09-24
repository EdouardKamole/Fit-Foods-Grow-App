import 'package:flutter/material.dart';
import 'content_moderation.dart';
import 'user_management.dart';

class AdminDashboard extends StatelessWidget {
  const AdminDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Dashboard'),
      ),
      body: GridView.count(
        padding: const EdgeInsets.all(16),
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        children: [
          _buildAdminCard('User Management', Icons.people, Colors.blue, () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const UserManagementScreen()));
          }),
          _buildAdminCard('Content Moderation', Icons.shield, Colors.orange,
              () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const ContentModerationScreen()));
          }),
          _buildAdminCard('Analytics', Icons.analytics, Colors.green, () {}),
          _buildAdminCard(
              'System Settings', Icons.settings, Colors.purple, () {}),
        ],
      ),
    );
  }

  Widget _buildAdminCard(
      String title, IconData icon, Color color, VoidCallback onTap) {
    return Card(
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 40, color: color),
              const SizedBox(height: 8),
              Text(title, textAlign: TextAlign.center),
            ],
          ),
        ),
      ),
    );
  }
}
