import 'package:hive/hive.dart';

part 'feedback_model.g.dart';

@HiveType(typeId: 6)
class Feedback {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String studentId;

  @HiveField(2)
  final String unitId;

  @HiveField(3)
  final String lecturerId;

  @HiveField(4)
  final String feedbackText;

  @HiveField(5)
  final DateTime timestamp; // Submission time.

  @HiveField(6)
  final DateTime? updatedAt; // Nullable field for last update time.

  Feedback({
    required this.id,
    required this.studentId,
    required this.unitId,
    required this.lecturerId,
    required this.feedbackText,
    required this.timestamp,
    this.updatedAt,
  });

  // Serialization
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'studentId': studentId,
      'unitId': unitId,
      'lecturerId': lecturerId,
      'feedbackText': feedbackText,
      'timestamp': timestamp.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }

  factory Feedback.fromMap(Map<String, dynamic> map) {
    return Feedback(
      id: map['id'],
      studentId: map['studentId'],
      unitId: map['unitId'],
      lecturerId: map['lecturerId'],
      feedbackText: map['feedbackText'],
      timestamp: DateTime.parse(map['timestamp']),
      updatedAt: map['updatedAt'] != null ? DateTime.parse(map['updatedAt']) : null,
    );
  }
}
