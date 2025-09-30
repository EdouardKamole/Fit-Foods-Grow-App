import 'package:flutter/material.dart';

class UserManagementScreen extends StatelessWidget {
  const UserManagementScreen({super.key});

  final List<Map<String, dynamic>> _users = const [
    {
      'name': 'Alice Johnson',
      'email': 'alice@example.com',
      'status': 'Active',
      'joinDate': '2024-01-15',
    },
    {
      'name': 'Bob Smith',
      'email': 'bob@example.com',
      'status': 'Inactive',
      'joinDate': '2024-01-10',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Management'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _users.length,
        itemBuilder: (context, index) {
          final user = _users[index];
          return Card(
            child: ListTile(
              leading: CircleAvatar(
                child: Text(user['name'][0]),
              ),
              title: Text(user['name']),
              subtitle: Text(user['email']),
              trailing: Chip(
                label: Text(user['status']),
                backgroundColor: user['status'] == 'Active' ? Colors.green[100] : Colors.red[100],
              ),
              onTap: () => _showUserDetails(user),
            ),
          );
        },
      ),
    );
  }

  void _showUserDetails(Map<String, dynamic> user) {
    // Implement user details dialog
  }
}