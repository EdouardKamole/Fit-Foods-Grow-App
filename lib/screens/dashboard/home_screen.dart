import 'package:flutter/material.dart';
import '../../services/auth_service.dart';
import '../../models/plant_model.dart';
import '../../models/achievement_model.dart';
import '../../models/user_model.dart'; // Added missing import
import '../../widgets/plant_card.dart';
import '../../widgets/achievement_badge.dart';
import 'garden_tracker_screen.dart';
import 'camera_screen.dart';
import 'achievements_screen.dart';
import 'leaderboard_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  final AuthService _authService = AuthService();

  // Mock data - will be replaced with real data from backend
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
  ];

  final List<AchievementModel> _recentAchievements = [
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
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fit Foods Grow'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              // TODO: Implement notifications screen navigation
            },
          ),
          IconButton(
            icon: const Icon(Icons.account_circle),
            onPressed: () {
              // TODO: Implement profile screen navigation
            },
          ),
        ],
      ),
      body: _buildCurrentScreen(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.green, // Added for better UX
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.eco), label: 'Garden'),
          BottomNavigationBarItem(
              icon: Icon(Icons.camera_alt), label: 'Camera'),
          BottomNavigationBarItem(
              icon: Icon(Icons.emoji_events), label: 'Achievements'),
          BottomNavigationBarItem(
              icon: Icon(Icons.leaderboard), label: 'Leaderboard'),
        ],
      ),
    );
  }

  Widget _buildCurrentScreen() {
    switch (_currentIndex) {
      case 0:
        return _buildHomeScreen();
      case 1:
        return const GardenTrackerScreen();
      case 2:
        return const CameraScreen();
      case 3:
        return AchievementsScreen();
      case 4:
        return const LeaderboardScreen();
      default:
        return _buildHomeScreen();
    }
  }

  Widget _buildHomeScreen() {
    final user = _authService.currentUser;

    // Added null check to prevent runtime errors
    if (user == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildWelcomeCard(user),
          const SizedBox(height: 24),
          _buildPlantsSection(),
          const SizedBox(height: 24),
          _buildAchievementsSection(),
          const SizedBox(height: 24),
          _buildQuickActions(),
        ],
      ),
    );
  }

  Widget _buildWelcomeCard(UserModel user) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundColor: Colors.green[100],
              child: const Icon(Icons.person, size: 30, color: Colors.green),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Hello, ${user.name}!',
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Level ${user.level} • ${user.points} points',
                    style: const TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 8),
                  LinearProgressIndicator(
                    value: (user.points % 1000) / 1000,
                    backgroundColor: Colors.grey[300],
                    valueColor:
                        const AlwaysStoppedAnimation<Color>(Colors.green),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlantsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Your Plants',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            if (_plants.isNotEmpty)
              TextButton(
                onPressed: () => setState(() => _currentIndex = 1),
                child: const Text('View All'),
              ),
          ],
        ),
        const SizedBox(height: 16),
        if (_plants.isEmpty)
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  const Icon(Icons.eco, size: 48, color: Colors.grey),
                  const SizedBox(height: 8),
                  const Text(
                    'No plants yet!',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  const Text('Start your garden by adding your first plant'),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _handleAddPlant,
                    child: const Text('Add Plant'),
                  ),
                ],
              ),
            ),
          )
        else
          ..._plants.map((plant) => Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: PlantCard(
                  plant: plant,
                  onTap: () => _handlePlantTap(plant),
                ),
              )),
      ],
    );
  }

  Widget _buildAchievementsSection() {
    final unlockedAchievements =
        _recentAchievements.where((a) => a.isUnlocked).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Recent Achievements',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            if (unlockedAchievements.isNotEmpty)
              TextButton(
                onPressed: () => setState(() => _currentIndex = 3),
                child: const Text('View All'),
              ),
          ],
        ),
        const SizedBox(height: 16),
        if (unlockedAchievements.isEmpty)
          const Card(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  Icon(Icons.emoji_events, size: 48, color: Colors.grey),
                  SizedBox(height: 8),
                  Text(
                    'No achievements yet!',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text('Complete tasks to unlock achievements'),
                ],
              ),
            ),
          )
        else
          SizedBox(
            height: 100,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: unlockedAchievements.length,
              itemBuilder: (context, index) {
                final achievement = unlockedAchievements[index];
                return Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: GestureDetector(
                    onTap: () => _handleAchievementTap(achievement),
                    child: Column(
                      children: [
                        AchievementBadge(achievement: achievement, size: 60),
                        const SizedBox(height: 8),
                        SizedBox(
                          width: 80,
                          child: Text(
                            achievement.title,
                            style: const TextStyle(fontSize: 12),
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
      ],
    );
  }

  Widget _buildQuickActions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Quick Actions',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 1.2,
          children: [
            _buildActionCard(
                'Add Plant', Icons.add, Colors.green, _handleAddPlant),
            _buildActionCard(
                'Take Photo', Icons.camera_alt, Colors.blue, _handleTakePhoto),
            _buildActionCard(
                'Learn', Icons.school, Colors.orange, _handleLearn),
            _buildActionCard(
                'Challenges', Icons.flag, Colors.purple, _handleChallenges),
          ],
        ),
      ],
    );
  }

  Widget _buildActionCard(
      String title, IconData icon, Color color, VoidCallback onTap) {
    return Card(
      elevation: 2,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 40, color: color),
              const SizedBox(height: 8),
              Text(
                title,
                textAlign: TextAlign.center,
                style:
                    const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Action handlers
  void _handleAddPlant() {
    // TODO: Navigate to add plant screen or show dialog
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Add Plant feature coming soon!')),
    );
  }

  void _handleTakePhoto() {
    setState(() => _currentIndex = 2);
  }

  void _handleLearn() {
    // TODO: Navigate to learning/educational content screen
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Learning section coming soon!')),
    );
  }

  void _handleChallenges() {
    // TODO: Navigate to challenges screen
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Challenges feature coming soon!')),
    );
  }

  void _handlePlantTap(PlantModel plant) {
    // TODO: Navigate to plant detail screen
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Viewing ${plant.name} details')),
    );
  }

  void _handleAchievementTap(AchievementModel achievement) {
    // TODO: Show achievement detail dialog
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(achievement.title),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(achievement.icon, style: const TextStyle(fontSize: 48)),
            const SizedBox(height: 16),
            Text(achievement.description),
            const SizedBox(height: 8),
            Text('${achievement.pointsReward} points'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}
