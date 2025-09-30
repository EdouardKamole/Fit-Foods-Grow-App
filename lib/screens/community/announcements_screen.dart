import 'package:flutter/material.dart';

class AnnouncementsScreen extends StatelessWidget {
  const AnnouncementsScreen({super.key});

  final List<Map<String, dynamic>> _announcements = const [
    {
      'title': 'New Learning Module Available!',
      'content': 'Check out our new module on organic gardening techniques.',
      'date': '2 hours ago',
      'important': true,
    },
    {
      'title': 'Maintenance Schedule',
      'content': 'The app will be undergoing maintenance this weekend.',
      'date': '1 day ago',
      'important': false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Announcements'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _announcements.length,
        itemBuilder: (context, index) {
          final announcement = _announcements[index];
          return Card(
            color: announcement['important'] ? Colors.orange[50] : null,
            child: ListTile(
              leading: Icon(
                announcement['important'] ? Icons.warning : Icons.info,
                color: announcement['important'] ? Colors.orange : Colors.blue,
              ),
              title: Text(announcement['title']),
              subtitle: Text(announcement['content']),
              trailing: Text(announcement['date']),
            ),
          );
        },
      ),
    );
  }
}