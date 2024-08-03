import 'package:flutter/material.dart';
import 'package:todolist/models/hive_todo_model.dart';
import 'package:todolist/pages/home_page.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main(List<String> args) async {
  await Hive.initFlutter();
  await Hive.openBox<HiveTodoModel>("todo");

  Hive.registerAdapter(HiveTodoModelAdapter());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "ToDo List",
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
