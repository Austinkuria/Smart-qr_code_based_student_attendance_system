// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'audit_log.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AuditLogModelAdapter extends TypeAdapter<AuditLogModel> {
  @override
  final int typeId = 2;

  @override
  AuditLogModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AuditLogModel(
      id: fields[0] as String,
      userId: fields[1] as String,
      actionPerformed: fields[2] as String,
      timestamp: fields[3] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, AuditLogModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.userId)
      ..writeByte(2)
      ..write(obj.actionPerformed)
      ..writeByte(3)
      ..write(obj.timestamp);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AuditLogModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
