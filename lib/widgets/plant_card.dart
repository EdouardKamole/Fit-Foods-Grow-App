import 'package:flutter/material.dart';
import '../models/plant_model.dart';

class PlantCard extends StatelessWidget {
  final PlantModel plant;
  final VoidCallback onTap;

  const PlantCard({
    super.key,
    required this.plant,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  plant.imageUrl,
                  height: 120,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: 120,
                      color: Colors.grey[200],
                      child: const Icon(Icons.photo, size: 40),
                    );
                  },
                ),
              ),
              const SizedBox(height: 12),
              Text(
                plant.name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Chip(
                    label: Text(plant.difficulty),
                    backgroundColor: _getDifficultyColor(plant.difficulty),
                  ),
                  const Spacer(),
                  Text('${plant.currentGrowth}/${plant.growthDays} days'),
                ],
              ),
              const SizedBox(height: 8),
              LinearProgressIndicator(
                value: plant.growthPercentage,
                backgroundColor: Colors.grey[300],
                color: Colors.green,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _getDifficultyColor(String difficulty) {
    switch (difficulty.toLowerCase()) {
      case 'easy':
        return Colors.green[100]!;
      case 'medium':
        return Colors.orange[100]!;
      case 'hard':
        return Colors.red[100]!;
      default:
        return Colors.grey[100]!;
    }
  }
}