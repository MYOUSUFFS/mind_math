// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SpendingDataAdapter extends TypeAdapter<SpendingData> {
  @override
  final int typeId = 0;

  @override
  SpendingData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SpendingData(
      (fields[0] as List).cast<AmountData>(),
    );
  }

  @override
  void write(BinaryWriter writer, SpendingData obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.spending);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SpendingDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
