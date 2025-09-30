class CampaignModel {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final DateTime startDate;
  final DateTime endDate;
  final int participantCount;
  final bool isActive;
  final String organizer;

  CampaignModel({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.startDate,
    required this.endDate,
    required this.participantCount,
    required this.isActive,
    required this.organizer,
  });

  bool get isOngoing => DateTime.now().isAfter(startDate) && DateTime.now().isBefore(endDate);

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'imageUrl': imageUrl,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
      'participantCount': participantCount,
      'isActive': isActive,
      'organizer': organizer,
    };
  }

  static CampaignModel fromJson(Map<String, dynamic> json) {
    return CampaignModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      imageUrl: json['imageUrl'],
      startDate: DateTime.parse(json['startDate']),
      endDate: DateTime.parse(json['endDate']),
      participantCount: json['participantCount'],
      isActive: json['isActive'],
      organizer: json['organizer'],
    );
  }
}