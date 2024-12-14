// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'system_setting.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SystemSettingAdapter extends TypeAdapter<SystemSetting> {
  @override
  final int typeId = 7;

  @override
  SystemSetting read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SystemSetting(
      settingId: fields[0] as String,
      key: fields[1] as String,
      value: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, SystemSetting obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.settingId)
      ..writeByte(1)
      ..write(obj.key)
      ..writeByte(2)
      ..write(obj.value);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SystemSettingAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
