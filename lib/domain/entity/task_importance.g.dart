// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_importance.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TaskImportantAdapter extends TypeAdapter<TaskImportant> {
  @override
  final int typeId = 2;

  @override
  TaskImportant read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return TaskImportant.basic;
      case 1:
        return TaskImportant.low;
      case 2:
        return TaskImportant.important;
      default:
        return TaskImportant.basic;
    }
  }

  @override
  void write(BinaryWriter writer, TaskImportant obj) {
    switch (obj) {
      case TaskImportant.basic:
        writer.writeByte(0);
        break;
      case TaskImportant.low:
        writer.writeByte(1);
        break;
      case TaskImportant.important:
        writer.writeByte(2);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TaskImportantAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
