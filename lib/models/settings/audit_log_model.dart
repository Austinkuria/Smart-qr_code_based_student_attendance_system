import 'package:hive/hive.dart';

part 'audit_logs_model.g.dart';

@HiveType(typeId: 7)
class AuditLog {
  @HiveField(0)
  final String id; // Unique log ID.

  @HiveField(1)
  final String userId; // ID of the user performing the action.

  @HiveField(2)
  final String role; // Role of the user (e.g., "Admin", "Lecturer", "Student").

  @HiveField(3)
  final String action; // Description of the action performed.

  @HiveField(4)
  final DateTime timestamp; // Time when the action occurred.

  AuditLog({
    required this.id,
    required this.userId,
    required this.role,
    required this.action,
    required this.timestamp,
  });

  // Serialization
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'role': role,
      'action': action,
      'timestamp': timestamp.toIso8601String(),
    };
  }

  factory AuditLog.fromMap(Map<String, dynamic> map) {
    return AuditLog(
      id: map['id'],
      userId: map['userId'],
      role: map['role'],
      action: map['action'],
      timestamp: DateTime.parse(map['timestamp']),
    );
  }
}
