import 'package:flutter/material.dart';
import '../../models/achievement_model.dart';
import '../../widgets/achievement_badge.dart';

class AchievementsScreen extends StatelessWidget {
  AchievementsScreen({super.key});

  final List<AchievementModel> _achievements = [
    AchievementModel(
      id: '1',
      title: 'First Plant',
      description: 'Planted your first seed',
      icon: '🌱',
      pointsReward: 50,
      isUnlocked: true,
      unlockedDate: DateTime.now().subtract(const Duration(days: 2)),
      category: 'Gardening',
    ),
    AchievementModel(
      id: '2',
      title: 'Watering Pro',
      description: 'Watered plants for 7 consecutive days',
      icon: '💧',
      pointsReward: 100,
      isUnlocked: false,
      category: 'Consistency',
    ),
    AchievementModel(
      id: '3',
      title: 'Harvest Master',
      description: 'Harvested 5 different plants',
      icon: '🌽',
      pointsReward: 200,
      isUnlocked: false,
      category: 'Gardening',
    ),
    AchievementModel(
      id: '4',
      title: 'Quiz Champion',
      description: 'Completed all gardening quizzes',
      icon: '🏆',
      pointsReward: 150,
      isUnlocked: true,
      unlockedDate: DateTime.now().subtract(const Duration(days: 1)),
      category: 'Education',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final unlocked = _achievements.where((a) => a.isUnlocked).toList();
    final locked = _achievements.where((a) => !a.isUnlocked).toList();

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Achievements'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Unlocked'),
              Tab(text: 'Locked'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildAchievementsList(unlocked),
            _buildAchievementsList(locked),
          ],
        ),
      ),
    );
  }

  Widget _buildAchievementsList(List<AchievementModel> achievements) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: achievements.length,
      itemBuilder: (context, index) {
        final achievement = achievements[index];
        return Card(
          child: ListTile(
            leading: AchievementBadge(achievement: achievement, size: 50),
            title: Text(achievement.title),
            subtitle: Text(achievement.description),
            trailing: Text('+${achievement.pointsReward} pts'),
          ),
        );
      },
    );
  }
}
