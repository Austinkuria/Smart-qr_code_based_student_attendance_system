// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NotificationAdapter extends TypeAdapter<Notification> {
  @override
  final int typeId = 4;

  @override
  Notification read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Notification(
      notificationId: fields[0] as String,
      userId: fields[1] as String,
      title: fields[2] as String,
      message: fields[3] as String,
      readStatus: fields[4] as bool,
      timestamp: fields[5] as DateTime,
      category: fields[6] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Notification obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.notificationId)
      ..writeByte(1)
      ..write(obj.userId)
      ..writeByte(2)
      ..write(obj.title)
      ..writeByte(3)
      ..write(obj.message)
      ..writeByte(4)
      ..write(obj.readStatus)
      ..writeByte(5)
      ..write(obj.timestamp)
      ..writeByte(6)
      ..write(obj.category);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NotificationAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
