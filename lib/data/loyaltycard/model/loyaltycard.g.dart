// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'loyaltycard.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LoyaltyCardAdapter extends TypeAdapter<LoyaltyCard> {
  @override
  final typeId = 0;

  @override
  LoyaltyCard read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LoyaltyCard()
      ..name = fields[0] as String
      ..number = fields[1] as String;
  }

  @override
  void write(BinaryWriter writer, LoyaltyCard obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.number);
  }
}
