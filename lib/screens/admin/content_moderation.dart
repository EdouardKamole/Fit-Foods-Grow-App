import 'package:flutter/material.dart';

class ContentModerationScreen extends StatelessWidget {
  const ContentModerationScreen({super.key});

  final List<Map<String, dynamic>> _reports = const [
    {
      'type': 'Inappropriate Content',
      'reporter': 'User123',
      'status': 'Pending',
      'date': '2024-01-20',
    },
    {
      'type': 'Spam',
      'reporter': 'User456',
      'status': 'Resolved',
      'date': '2024-01-19',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Content Moderation'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _reports.length,
        itemBuilder: (context, index) {
          final report = _reports[index];
          return Card(
            child: ListTile(
              leading: Icon(
                Icons.warning,
                color: report['status'] == 'Pending' ? Colors.orange : Colors.green,
              ),
              title: Text(report['type']),
              subtitle: Text('Reported by ${report['reporter']}'),
              trailing: Chip(
                label: Text(report['status']),
                backgroundColor: report['status'] == 'Pending' ? Colors.orange[100] : Colors.green[100],
              ),
              onTap: () => _showReportDetails(report),
            ),
          );
        },
      ),
    );
  }

  void _showReportDetails(Map<String, dynamic> report) {
    // Implement report details dialog
  }
}