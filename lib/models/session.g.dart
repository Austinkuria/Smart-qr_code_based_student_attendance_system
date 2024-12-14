// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SessionAdapter extends TypeAdapter<Session> {
  @override
  final int typeId = 6;

  @override
  Session read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Session(
      sessionId: fields[0] as String,
      classId: fields[1] as String,
      startTime: fields[2] as DateTime,
      endTime: fields[3] as DateTime,
      qrCode: fields[4] as String?,
      status: fields[5] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Session obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.sessionId)
      ..writeByte(1)
      ..write(obj.classId)
      ..writeByte(2)
      ..write(obj.startTime)
      ..writeByte(3)
      ..write(obj.endTime)
      ..writeByte(4)
      ..write(obj.qrCode)
      ..writeByte(5)
      ..write(obj.status);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SessionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
