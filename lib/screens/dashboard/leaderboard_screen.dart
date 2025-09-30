import 'package:flutter/material.dart';

class LeaderboardScreen extends StatelessWidget {
  const LeaderboardScreen({super.key});

  final List<Map<String, dynamic>> _leaderboardData = const [
    {'name': 'Alice', 'points': 1250, 'level': 5},
    {'name': 'Bob', 'points': 980, 'level': 4},
    {'name': 'Charlie', 'points': 750, 'level': 3},
    {'name': 'Diana', 'points': 620, 'level': 3},
    {'name': 'Evan', 'points': 450, 'level': 2},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Leaderboard'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _leaderboardData.length,
        itemBuilder: (context, index) {
          final user = _leaderboardData[index];
          return Card(
            child: ListTile(
              leading: CircleAvatar(
                child: Text('${index + 1}'),
              ),
              title: Text(user['name']),
              subtitle: Text('Level ${user['level']}'),
              trailing: Text('${user['points']} pts'),
            ),
          );
        },
      ),
    );
  }
}