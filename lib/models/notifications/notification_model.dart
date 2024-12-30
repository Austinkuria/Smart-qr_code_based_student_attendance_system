import 'package:hive/hive.dart';

part 'notification_model.g.dart';

@HiveType(typeId: 11)
class Notification {
  @HiveField(0)
  final String id; // Unique notification ID.

  @HiveField(1)
  final String userId; // ID of the user receiving the notification.

  @HiveField(2)
  final String role; // Role of the user (e.g., "Student", "Lecturer", "Admin").

  @HiveField(3)
  final String title; // Title of the notification.

  @HiveField(4)
  final String message; // Detailed notification message.

  @HiveField(5)
  final DateTime timestamp; // Time the notification was created.

  @HiveField(6)
  final bool isRead; // Whether the notification has been read.

  @HiveField(7)
  final String? relatedId; // ID for related entities (e.g.,  sessionId).

  Notification({
    required this.id,
    required this.userId,
    required this.role,
    required this.title,
    required this.message,
    required this.timestamp,
    this.isRead = false,
    this.relatedId,
  });

  // Serialization
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'role': role,
      'title': title,
      'message': message,
      'timestamp': timestamp.toIso8601String(),
      'isRead': isRead,
      'relatedId': relatedId,
    };
  }

  factory Notification.fromMap(Map<String, dynamic> map) {
    return Notification(
      id: map['id'],
      userId: map['userId'],
      role: map['role'],
      title: map['title'],
      message: map['message'],
      timestamp: DateTime.parse(map['timestamp']),
      isRead: map['isRead'] ?? false,
      relatedId: map['relatedId'],
    );
  }
}
