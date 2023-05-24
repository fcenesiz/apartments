// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fee.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FeeAdapter extends TypeAdapter<Fee> {
  @override
  final int typeId = 2;

  @override
  Fee read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Fee()
      ..quantity = fields[0] as double
      ..realizedQuantity = fields[1] as double
      ..month = fields[2] as int
      ..sMonth = fields[3] as String
      ..year = fields[4] as int;
  }

  @override
  void write(BinaryWriter writer, Fee obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.quantity)
      ..writeByte(1)
      ..write(obj.realizedQuantity)
      ..writeByte(2)
      ..write(obj.month)
      ..writeByte(3)
      ..write(obj.sMonth)
      ..writeByte(4)
      ..write(obj.year);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FeeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
