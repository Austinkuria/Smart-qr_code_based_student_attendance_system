import 'package:hive/hive.dart';

part 'system_settings_model.g.dart';

@HiveType(typeId: 8)
class SystemSetting {
  @HiveField(0)
  final String id; // Unique setting ID.

  @HiveField(1)
  final String name; // Name of the setting (e.g., "AttendanceThreshold").

  @HiveField(2)
  final String value; // Value of the setting (e.g., "30" for 30 minutes).

  @HiveField(3)
  final String description; // Description of what the setting does.

  SystemSetting({
    required this.id,
    required this.name,
    required this.value,
    required this.description,
  });

  // Serialization
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'value': value,
      'description': description,
    };
  }

  factory SystemSetting.fromMap(Map<String, dynamic> map) {
    return SystemSetting(
      id: map['id'],
      name: map['name'],
      value: map['value'],
      description: map['description'],
    );
  }
}
