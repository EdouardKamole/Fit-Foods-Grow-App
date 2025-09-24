class AchievementModel {
  final String id;
  final String title;
  final String description;
  final String icon;
  final int pointsReward;
  final bool isUnlocked;
  final DateTime? unlockedDate;
  final String category;

  AchievementModel({
    required this.id,
    required this.title,
    required this.description,
    required this.icon,
    required this.pointsReward,
    required this.isUnlocked,
    this.unlockedDate,
    required this.category,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'icon': icon,
      'pointsReward': pointsReward,
      'isUnlocked': isUnlocked,
      'unlockedDate': unlockedDate?.toIso8601String(),
      'category': category,
    };
  }

  static AchievementModel fromJson(Map<String, dynamic> json) {
    return AchievementModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      icon: json['icon'],
      pointsReward: json['pointsReward'],
      isUnlocked: json['isUnlocked'],
      unlockedDate: json['unlockedDate'] != null
          ? DateTime.parse(json['unlockedDate'])
          : null,
      category: json['category'],
    );
  }
}
