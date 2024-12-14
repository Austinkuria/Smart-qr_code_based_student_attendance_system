// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attendance.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AttendanceModelAdapter extends TypeAdapter<AttendanceModel> {
  @override
  final int typeId = 1;

  @override
  AttendanceModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AttendanceModel(
      attendanceId: fields[0] as String,
      sessionId: fields[1] as String,
      studentId: fields[2] as String,
      status: fields[3] as String,
      timestamp: fields[4] as DateTime,
      deviceId: fields[5] as String?,
      location: fields[6] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, AttendanceModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.attendanceId)
      ..writeByte(1)
      ..write(obj.sessionId)
      ..writeByte(2)
      ..write(obj.studentId)
      ..writeByte(3)
      ..write(obj.status)
      ..writeByte(4)
      ..write(obj.timestamp)
      ..writeByte(5)
      ..write(obj.deviceId)
      ..writeByte(6)
      ..write(obj.location);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AttendanceModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
