import 'package:hive/hive.dart';

part 'feedback.g.dart';

@HiveType(typeId: 0)
class Feedback {
  @HiveField(0)
  final String feedbackId;

  @HiveField(1)
  final String userId;

  @HiveField(2)
  final String sessionId;

  @HiveField(3)
  final String content;

  @HiveField(4)
  final double? rating; // Optional rating

  @HiveField(5)
  final DateTime timestamp;

  Feedback({
    required this.feedbackId,
    required this.userId,
    required this.sessionId,
    required this.content,
    this.rating,
    required this.timestamp,
  });
}
