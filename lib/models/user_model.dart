class UserModel {
  final String id;
  final String email;
  final String name;
  final int age;
  final String profileImage;
  final int points;
  final int level;
  final DateTime joinDate;
  final bool isParentVerified;

  UserModel({
    required this.id,
    required this.email,
    required this.name,
    required this.age,
    required this.profileImage,
    required this.points,
    required this.level,
    required this.joinDate,
    required this.isParentVerified,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'age': age,
      'profileImage': profileImage,
      'points': points,
      'level': level,
      'joinDate': joinDate.toIso8601String(),
      'isParentVerified': isParentVerified,
    };
  }

  static UserModel fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      email: json['email'],
      name: json['name'],
      age: json['age'],
      profileImage: json['profileImage'],
      points: json['points'],
      level: json['level'],
      joinDate: DateTime.parse(json['joinDate']),
      isParentVerified: json['isParentVerified'],
    );
  }
}