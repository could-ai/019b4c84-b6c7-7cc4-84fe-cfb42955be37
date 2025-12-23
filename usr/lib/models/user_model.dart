class UserModel {
  final String id;
  final String email;
  final String fullName;
  final String role; // 'client' or 'freelancer'
  final String? bio;
  final String? avatarUrl;
  final List<String> skills;
  final double rating;
  final int reviewCount;
  final int completedTasks;
  final List<String> badges;
  final DateTime createdAt;

  UserModel({
    required this.id,
    required this.email,
    required this.fullName,
    required this.role,
    this.bio,
    this.avatarUrl,
    this.skills = const [],
    this.rating = 0.0,
    this.reviewCount = 0,
    this.completedTasks = 0,
    this.badges = const [],
    required this.createdAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      email: json['email'] as String,
      fullName: json['full_name'] as String,
      role: json['role'] as String,
      bio: json['bio'] as String?,
      avatarUrl: json['avatar_url'] as String?,
      skills: (json['skills'] as List<dynamic>?)?.map((e) => e as String).toList() ?? [],
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      reviewCount: json['review_count'] as int? ?? 0,
      completedTasks: json['completed_tasks'] as int? ?? 0,
      badges: (json['badges'] as List<dynamic>?)?.map((e) => e as String).toList() ?? [],
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'full_name': fullName,
      'role': role,
      'bio': bio,
      'avatar_url': avatarUrl,
      'skills': skills,
      'rating': rating,
      'review_count': reviewCount,
      'completed_tasks': completedTasks,
      'badges': badges,
      'created_at': createdAt.toIso8601String(),
    };
  }

  UserModel copyWith({
    String? id,
    String? email,
    String? fullName,
    String? role,
    String? bio,
    String? avatarUrl,
    List<String>? skills,
    double? rating,
    int? reviewCount,
    int? completedTasks,
    List<String>? badges,
    DateTime? createdAt,
  }) {
    return UserModel(
      id: id ?? this.id,
      email: email ?? this.email,
      fullName: fullName ?? this.fullName,
      role: role ?? this.role,
      bio: bio ?? this.bio,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      skills: skills ?? this.skills,
      rating: rating ?? this.rating,
      reviewCount: reviewCount ?? this.reviewCount,
      completedTasks: completedTasks ?? this.completedTasks,
      badges: badges ?? this.badges,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
