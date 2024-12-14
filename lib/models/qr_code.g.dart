// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'qr_code.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class QRCodeAdapter extends TypeAdapter<QRCode> {
  @override
  final int typeId = 5;

  @override
  QRCode read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return QRCode(
      qrCodeId: fields[0] as String,
      sessionId: fields[1] as String,
      qrCodeData: fields[2] as String,
      timestamp: fields[3] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, QRCode obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.qrCodeId)
      ..writeByte(1)
      ..write(obj.sessionId)
      ..writeByte(2)
      ..write(obj.qrCodeData)
      ..writeByte(3)
      ..write(obj.timestamp);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is QRCodeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
