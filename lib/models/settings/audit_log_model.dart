import 'package:hive/hive.dart';

part 'audit_logs_model.g.dart';
@HiveType(typeId: 7)
class AuditLog {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String userId;

  @HiveField(2)
  final String role;

  @HiveField(3)
  final String action;

  @HiveField(4)
  final DateTime timestamp; // Already present.

  @HiveField(5)
  final DateTime createdAt; // New: Time when the log was created.

  @HiveField(6)
  final DateTime updatedAt; // New: Time when the log was last updated.

  AuditLog({
    required this.id,
    required this.userId,
    required this.role,
    required this.action,
    required this.timestamp,
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'role': role,
      'action': action,
      'timestamp': timestamp.toIso8601String(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  factory AuditLog.fromMap(Map<String, dynamic> map) {
    return AuditLog(
      id: map['id'],
      userId: map['userId'],
      role: map['role'],
      action: map['action'],
      timestamp: DateTime.parse(map['timestamp']),
      createdAt: DateTime.parse(map['createdAt']),
      updatedAt: DateTime.parse(map['updatedAt']),
    );
  }
}
