import 'package:hive/hive.dart';

part 'audit_log.g.dart';

@HiveType(typeId: 2)
class AuditLogModel extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String userId;

  @HiveField(2)
  final String actionPerformed;

  @HiveField(3)
  final DateTime timestamp;

  AuditLogModel({
    required this.id,
    required this.userId,
    required this.actionPerformed,
    required this.timestamp,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'actionPerformed': actionPerformed,
      'timestamp': timestamp.toIso8601String(),
    };
  }

  factory AuditLogModel.fromJson(Map<String, dynamic> json) {
    return AuditLogModel(
      id: json['id'],
      userId: json['userId'],
      actionPerformed: json['actionPerformed'],
      timestamp: DateTime.parse(json['timestamp']),
    );
  }
}
