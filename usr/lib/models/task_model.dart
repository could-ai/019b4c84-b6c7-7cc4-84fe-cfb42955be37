enum TaskType {
  tender, // Bidding system
  booking, // Direct hire with time slots
}

enum TaskStatus {
  open,
  inProgress,
  completed,
  cancelled,
}

class TaskModel {
  final String id;
  final String title;
  final String description;
  final TaskType type;
  final String category;
  final double budget;
  final TaskStatus status;
  final String clientId;
  final String clientName;
  final List<String> requiredSkills;
  final DateTime createdAt;
  final DateTime? deadline;
  final List<DateTime>? availableSlots; // For booking type
  final String? freelancerId; // Assigned freelancer
  final List<String>? attachments;

  TaskModel({
    required this.id,
    required this.title,
    required this.description,
    required this.type,
    required this.category,
    required this.budget,
    required this.status,
    required this.clientId,
    required this.clientName,
    this.requiredSkills = const [],
    required this.createdAt,
    this.deadline,
    this.availableSlots,
    this.freelancerId,
    this.attachments,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      type: TaskType.values.firstWhere(
        (e) => e.name == json['type'],
        orElse: () => TaskType.tender,
      ),
      category: json['category'] as String,
      budget: (json['budget'] as num).toDouble(),
      status: TaskStatus.values.firstWhere(
        (e) => e.name == json['status'],
        orElse: () => TaskStatus.open,
      ),
      clientId: json['client_id'] as String,
      clientName: json['client_name'] as String,
      requiredSkills: (json['required_skills'] as List<dynamic>?)?.map((e) => e as String).toList() ?? [],
      createdAt: DateTime.parse(json['created_at'] as String),
      deadline: json['deadline'] != null ? DateTime.parse(json['deadline'] as String) : null,
      availableSlots: (json['available_slots'] as List<dynamic>?)
          ?.map((e) => DateTime.parse(e as String))
          .toList(),
      freelancerId: json['freelancer_id'] as String?,
      attachments: (json['attachments'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'type': type.name,
      'category': category,
      'budget': budget,
      'status': status.name,
      'client_id': clientId,
      'client_name': clientName,
      'required_skills': requiredSkills,
      'created_at': createdAt.toIso8601String(),
      'deadline': deadline?.toIso8601String(),
      'available_slots': availableSlots?.map((e) => e.toIso8601String()).toList(),
      'freelancer_id': freelancerId,
      'attachments': attachments,
    };
  }

  TaskModel copyWith({
    String? id,
    String? title,
    String? description,
    TaskType? type,
    String? category,
    double? budget,
    TaskStatus? status,
    String? clientId,
    String? clientName,
    List<String>? requiredSkills,
    DateTime? createdAt,
    DateTime? deadline,
    List<DateTime>? availableSlots,
    String? freelancerId,
    List<String>? attachments,
  }) {
    return TaskModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      type: type ?? this.type,
      category: category ?? this.category,
      budget: budget ?? this.budget,
      status: status ?? this.status,
      clientId: clientId ?? this.clientId,
      clientName: clientName ?? this.clientName,
      requiredSkills: requiredSkills ?? this.requiredSkills,
      createdAt: createdAt ?? this.createdAt,
      deadline: deadline ?? this.deadline,
      availableSlots: availableSlots ?? this.availableSlots,
      freelancerId: freelancerId ?? this.freelancerId,
      attachments: attachments ?? this.attachments,
    );
  }

  bool get isTender => type == TaskType.tender;
  bool get isBooking => type == TaskType.booking;
  bool get isOpen => status == TaskStatus.open;
  bool get isInProgress => status == TaskStatus.inProgress;
  bool get isCompleted => status == TaskStatus.completed;
}
