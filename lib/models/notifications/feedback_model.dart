import 'package:hive/hive.dart';

part 'feedback_model.g.dart';

@HiveType(typeId: 6)
class Feedback {
  @HiveField(0)
  final String id; // Unique feedback ID.

  @HiveField(1)
  final String studentId; // ID of the student giving feedback.

  @HiveField(2)
  final String unitId; // ID of the unit related to the feedback.

  @HiveField(3)
  final String lecturerId; // ID of the lecturer related to the feedback.

  @HiveField(4)
  final String feedbackText; // The feedback text provided by the student.

  @HiveField(5)
  final DateTime timestamp; // Time when the feedback was submitted.

  Feedback({
    required this.id,
    required this.studentId,
    required this.unitId,
    required this.lecturerId,
    required this.feedbackText,
    required this.timestamp,
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
    );
  }
}
