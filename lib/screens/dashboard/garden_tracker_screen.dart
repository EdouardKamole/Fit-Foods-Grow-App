import 'package:flutter/material.dart';
import '../../models/plant_model.dart';
import '../../widgets/plant_card.dart';

class GardenTrackerScreen extends StatefulWidget {
  const GardenTrackerScreen({super.key});

  @override
  State<GardenTrackerScreen> createState() => _GardenTrackerScreenState();
}

class _GardenTrackerScreenState extends State<GardenTrackerScreen> {
  final List<PlantModel> _plants = [
    PlantModel(
      id: '1',
      name: 'Tomato Plant',
      imageUrl: 'https://via.placeholder.com/150',
      growthDays: 30,
      currentGrowth: 15,
      plantedDate: DateTime.now().subtract(const Duration(days: 15)),
      isHarvested: false,
      difficulty: 'Easy',
    ),
    PlantModel(
      id: '2',
      name: 'Basil',
      imageUrl: 'https://via.placeholder.com/150',
      growthDays: 20,
      currentGrowth: 5,
      plantedDate: DateTime.now().subtract(const Duration(days: 5)),
      isHarvested: false,
      difficulty: 'Easy',
    ),
    PlantModel(
      id: '3',
      name: 'Carrots',
      imageUrl: 'https://via.placeholder.com/150',
      growthDays: 40,
      currentGrowth: 30,
      plantedDate: DateTime.now().subtract(const Duration(days: 30)),
      isHarvested: false,
      difficulty: 'Medium',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Garden'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _showAddPlantDialog,
          ),
        ],
      ),
      body: _plants.isEmpty ? _buildEmptyState() : _buildPlantsList(),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.eco, size: 80, color: Colors.grey[300]),
          const SizedBox(height: 16),
          const Text(
            'No plants yet',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text(
            'Start by adding your first plant!',
            style: TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: _showAddPlantDialog,
            icon: const Icon(Icons.add),
            label: const Text('Add First Plant'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlantsList() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _plants.length,
      itemBuilder: (context, index) {
        final plant = _plants[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: PlantCard(
            plant: plant,
            onTap: () => _showPlantDetails(plant),
          ),
        );
      },
    );
  }

  void _showAddPlantDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add New Plant'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              decoration: const InputDecoration(labelText: 'Plant Name'),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField(
              items: ['Easy', 'Medium', 'Hard']
                  .map((level) => DropdownMenuItem(value: level, child: Text(level)))
                  .toList(),
              decoration: const InputDecoration(labelText: 'Difficulty'),
              onChanged: (value) {},
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              // Add plant logic
              Navigator.pop(context);
            },
            child: const Text('Add Plant'),
          ),
        ],
      ),
    );
  }

  void _showPlantDetails(PlantModel plant) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              plant.name,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Chip(label: Text(plant.difficulty)),
                const Spacer(),
                Text('${plant.currentGrowth}/${plant.growthDays} days'),
              ],
            ),
            const SizedBox(height: 16),
            LinearProgressIndicator(
              value: plant.growthPercentage,
              backgroundColor: Colors.grey[300],
              color: Colors.green,
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Water plant logic
                  Navigator.pop(context);
                },
                child: const Text('Water Plant'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}