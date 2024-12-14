import 'package:hive/hive.dart';

part 'system_setting.g.dart';

@HiveType(typeId: 7)
class SystemSetting {
  @HiveField(0)
  final String settingId;

  @HiveField(1)
  final String key;

  @HiveField(2)
  final String value;

  SystemSetting({
    required this.settingId,
    required this.key,
    required this.value,
  });
}
