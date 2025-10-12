class Activity {
  final String id;
  final String icon;
  final String title;
  final String category;
  final String difficulty;
  final String duration;
  final String description;
  final List<String> benefits;
  final List<String> howToStart;
  final DateTime createdAt;
  final DateTime updatedAt;

  Activity({
    required this.id,
    required this.icon,
    required this.title,
    required this.category,
    required this.difficulty,
    required this.duration,
    required this.description,
    required this.benefits,
    required this.howToStart,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Activity.fromJson(Map<String, dynamic> json) {
    return Activity(
      id: json['id'] as String,
      icon: json['icon'] as String,
      title: json['title'] as String,
      category: json['category'] as String,
      difficulty: json['difficulty'] as String,
      duration: json['duration'] as String,
      description: json['description'] as String,
      benefits: (json['benefits'] as List<dynamic>).map((e) => e as String).toList(),
      howToStart: (json['howToStart'] as List<dynamic>).map((e) => e as String).toList(),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'icon': icon,
    'title': title,
    'category': category,
    'difficulty': difficulty,
    'duration': duration,
    'description': description,
    'benefits': benefits,
    'howToStart': howToStart,
    'createdAt': createdAt.toUtc().toIso8601String(),
    'updatedAt': updatedAt.toUtc().toIso8601String(),
  };
}