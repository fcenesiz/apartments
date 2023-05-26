// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'year.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class YearAdapter extends TypeAdapter<Year> {
  @override
  final int typeId = 3;

  @override
  Year read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Year()
      ..number = fields[0] as int
      ..offsetMonth = fields[1] as int
      ..feeQuantity = fields[2] as double;
  }

  @override
  void write(BinaryWriter writer, Year obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.number)
      ..writeByte(1)
      ..write(obj.offsetMonth)
      ..writeByte(2)
      ..write(obj.feeQuantity);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is YearAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
