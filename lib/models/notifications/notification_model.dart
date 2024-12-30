import 'package:hive/hive.dart';

part 'notification.g.dart';

@HiveType(typeId: 4)
class Notification {
  @HiveField(0)
  final String notificationId;

  @HiveField(1)
  final String userId;

  @HiveField(2)
  final String title;

  @HiveField(3)
  final String message;

  @HiveField(4)
  bool readStatus;

  @HiveField(5)
  final DateTime timestamp;

  @HiveField(6)
  final String? category; // Optional category for notifications

  Notification({
    required this.notificationId,
    required this.userId,
    required this.title,
    required this.message,
    this.readStatus = false,
    required this.timestamp,
    this.category,
  });
}
