import 'package:hive/hive.dart';

part 'system_settings_model.g.dart';

@HiveType(typeId: 8)
class SystemSetting {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String value;

  @HiveField(3)
  final String description;

  @HiveField(4)
  final DateTime createdAt; // When the setting was created.

  @HiveField(5)
  final DateTime updatedAt; // When the setting was last updated.

  SystemSetting({
    required this.id,
    required this.name,
    required this.value,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
  });

  // Serialization
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'value': value,
      'description': description,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  factory SystemSetting.fromMap(Map<String, dynamic> map) {
    return SystemSetting(
      id: map['id'],
      name: map['name'],
      value: map['value'],
      description: map['description'],
      createdAt: DateTime.parse(map['createdAt']),
      updatedAt: DateTime.parse(map['updatedAt']),
    );
  }
}
