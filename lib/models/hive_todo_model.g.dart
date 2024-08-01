// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_todo_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HiveTodoModelAdapter extends TypeAdapter<HiveTodoModel> {
  @override
  final int typeId = 0;

  @override
  HiveTodoModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HiveTodoModel(
      todoHeading: fields[1] as String?,
      todoDescription: fields[2] as String?,
      todoType: fields[3] as String?,
      completedTask: fields[4] as bool?,
    )..todoID = fields[0] as String?;
  }

  @override
  void write(BinaryWriter writer, HiveTodoModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.todoID)
      ..writeByte(1)
      ..write(obj.todoHeading)
      ..writeByte(2)
      ..write(obj.todoDescription)
      ..writeByte(3)
      ..write(obj.todoType)
      ..writeByte(4)
      ..write(obj.completedTask);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HiveTodoModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
