import 'package:flutter/material.dart';
import 'video_player_screen.dart';
import 'quiz_screen.dart';

class LessonsScreen extends StatelessWidget {
  const LessonsScreen({super.key});

  final List<Map<String, dynamic>> _lessons = const [
    {
      'title': 'Introduction to Gardening',
      'description': 'Learn the basics of starting your garden',
      'duration': '15 min',
      'type': 'video',
      'completed': true,
    },
    {
      'title': 'Soil Preparation',
      'description': 'How to prepare soil for different plants',
      'duration': '20 min',
      'type': 'video',
      'completed': false,
    },
    {
      'title': 'Plant Nutrition Quiz',
      'description': 'Test your knowledge about plant nutrients',
      'duration': '10 min',
      'type': 'quiz',
      'completed': false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Learning Center'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _lessons.length,
        itemBuilder: (context, index) {
          final lesson = _lessons[index];
          return Card(
            child: ListTile(
              leading: CircleAvatar(
                child: Icon(lesson['type'] == 'video' ? Icons.play_arrow : Icons.quiz),
              ),
              title: Text(lesson['title']),
              subtitle: Text(lesson['description']),
              trailing: Chip(
                label: Text(lesson['duration']),
                backgroundColor: lesson['completed'] ? Colors.green : Colors.grey,
              ),
              onTap: () {
                if (lesson['type'] == 'video') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const VideoPlayerScreen()),
                  );
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const QuizScreen()),
                  );
                }
              },
            ),
          );
        },
      ),
    );
  }
}