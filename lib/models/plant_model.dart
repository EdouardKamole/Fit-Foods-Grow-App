class PlantModel {
  final String id;
  final String name;
  final String imageUrl;
  final int growthDays;
  final int currentGrowth;
  final DateTime plantedDate;
  final bool isHarvested;
  final String difficulty;

  PlantModel({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.growthDays,
    required this.currentGrowth,
    required this.plantedDate,
    required this.isHarvested,
    required this.difficulty,
  });

  double get growthPercentage => (currentGrowth / growthDays).clamp(0.0, 1.0);

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'imageUrl': imageUrl,
      'growthDays': growthDays,
      'currentGrowth': currentGrowth,
      'plantedDate': plantedDate.toIso8601String(),
      'isHarvested': isHarvested,
      'difficulty': difficulty,
    };
  }

  static PlantModel fromJson(Map<String, dynamic> json) {
    return PlantModel(
      id: json['id'],
      name: json['name'],
      imageUrl: json['imageUrl'],
      growthDays: json['growthDays'],
      currentGrowth: json['currentGrowth'],
      plantedDate: DateTime.parse(json['plantedDate']),
      isHarvested: json['isHarvested'],
      difficulty: json['difficulty'],
    );
  }
}