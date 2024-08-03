import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
part 'hive_todo_model.g.dart';

@HiveType(typeId: 0)
class HiveTodoModel extends HiveObject {
  @HiveField(0)
  String? todoID;
  @HiveField(1)
  String? todoHeading;
  @HiveField(2)
  String? todoDescription;
  @HiveField(3)
  String? todoType;
  @HiveField(4)
  bool? completedTask;

  HiveTodoModel({
    @required this.todoHeading,
    @required this.todoDescription,
    @required this.todoType,
    @required this.completedTask,
  });
}
