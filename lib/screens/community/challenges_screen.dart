import 'package:flutter/material.dart';

class ChallengesScreen extends StatelessWidget {
  const ChallengesScreen({super.key});

  final List<Map<String, dynamic>> _challenges = const [
    {
      'title': 'Weekly Watering Challenge',
      'description': 'Water your plants for 7 consecutive days',
      'reward': '50 points',
      'participants': 125,
      'endsIn': '3 days',
    },
    {
      'title': 'Harvest Festival',
      'description': 'Harvest 3 different types of plants',
      'reward': '100 points',
      'participants': 89,
      'endsIn': '1 week',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Community Challenges'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _challenges.length,
        itemBuilder: (context, index) {
          final challenge = _challenges[index];
          return Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    challenge['title'],
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(challenge['description']),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Chip(label: Text(challenge['reward'])),
                      const Spacer(),
                      Text('${challenge['participants']} participants'),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const LinearProgressIndicator(
                    value: 0.7, // Example progress
                  ),
                  const SizedBox(height: 8),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text('Ends in ${challenge['endsIn']}'),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: const Text('Join Challenge'),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}