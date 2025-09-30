import 'package:flutter/material.dart';
import '../models/achievement_model.dart';

class AchievementBadge extends StatelessWidget {
  final AchievementModel achievement;
  final double size;

  const AchievementBadge({
    super.key,
    required this.achievement,
    this.size = 80,
  });

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: achievement.title,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: achievement.isUnlocked ? Colors.amber : Colors.grey[300],
          shape: BoxShape.circle,
          border: Border.all(
            color: achievement.isUnlocked ? Colors.orange : Colors.grey,
            width: 3,
          ),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Icon(
              Icons.emoji_events,
              size: size * 0.6,
              color: achievement.isUnlocked ? Colors.white : Colors.grey[600],
            ),
            if (achievement.isUnlocked)
              Positioned(
                top: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                    color: Colors.green,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.check,
                    size: 12,
                    color: Colors.white,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}