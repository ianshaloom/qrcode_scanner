// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'myqrcode.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MyQrCodeAdapter extends TypeAdapter<MyQrCode> {
  @override
  final int typeId = 0;

  @override
  MyQrCode read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MyQrCode(
      id: fields[0] as String,
      qrType: fields[1] as String,
      qrData: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, MyQrCode obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.qrType)
      ..writeByte(2)
      ..write(obj.qrData);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MyQrCodeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
