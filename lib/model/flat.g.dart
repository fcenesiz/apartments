// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'flat.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FlatAdapter extends TypeAdapter<Flat> {
  @override
  final int typeId = 1;

  @override
  Flat read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Flat()
      ..ownerName = fields[0] as String
      ..no = fields[1] as int
      ..fees = (fields[2] as List).cast<Fee>();
  }

  @override
  void write(BinaryWriter writer, Flat obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.ownerName)
      ..writeByte(1)
      ..write(obj.no)
      ..writeByte(2)
      ..write(obj.fees);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FlatAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
