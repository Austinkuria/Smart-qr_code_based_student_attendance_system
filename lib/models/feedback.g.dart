// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feedback.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FeedbackAdapter extends TypeAdapter<Feedback> {
  @override
  final int typeId = 0;

  @override
  Feedback read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Feedback(
      feedbackId: fields[0] as String,
      userId: fields[1] as String,
      sessionId: fields[2] as String,
      content: fields[3] as String,
      rating: fields[4] as double?,
      timestamp: fields[5] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, Feedback obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.feedbackId)
      ..writeByte(1)
      ..write(obj.userId)
      ..writeByte(2)
      ..write(obj.sessionId)
      ..writeByte(3)
      ..write(obj.content)
      ..writeByte(4)
      ..write(obj.rating)
      ..writeByte(5)
      ..write(obj.timestamp);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FeedbackAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
