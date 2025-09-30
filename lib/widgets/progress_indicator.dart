import 'package:flutter/material.dart';

class CustomProgressIndicator extends StatelessWidget {
  final double progress;
  final double height;
  final Color backgroundColor;
  final Color progressColor;

  const CustomProgressIndicator({
    super.key,
    required this.progress,
    this.height = 8.0,
    this.backgroundColor = Colors.grey,
    this.progressColor = Colors.green,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(height / 2),
      ),
      child: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width * progress.clamp(0.0, 1.0),
            decoration: BoxDecoration(
              color: progressColor,
              borderRadius: BorderRadius.circular(height / 2),
            ),
          ),
        ],
      ),
    );
  }
}

class CircularProgressWithLabel extends StatelessWidget {
  final double progress;
  final double size;
  final String label;

  const CircularProgressWithLabel({
    super.key,
    required this.progress,
    required this.size,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              width: size,
              height: size,
              child: CircularProgressIndicator(
                value: progress,
                strokeWidth: 8,
                backgroundColor: Colors.grey[300],
                valueColor: AlwaysStoppedAnimation<Color>(Colors.green[400]!),
              ),
            ),
            Text(
              '${(progress * 100).toInt()}%',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(fontSize: 12),
        ),
      ],
    );
  }
}