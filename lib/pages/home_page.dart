import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todolist/models/hive_todo_model.dart';
import 'package:todolist/pages/floatingaction.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Box<HiveTodoModel> todoBox;

  @override
  void initState() {
    super.initState();
    todoBox = Hive.box<HiveTodoModel>('todo');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "ToDo List",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.deepPurple[300],
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.menu,
            color: Colors.white,
            size: 35,
          ),
        ),
        actions: [
          Container(
            height: 45,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(30)),
            child: TextButton.icon(
                onPressed: () {
                  deleteAllTodos();
                },
                icon: const Icon(
                  Icons.delete_forever_sharp,
                  color: Colors.red,
                  size: 30,
                ),
                label: const Text(
                  "Delete All",
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                )),
          ),
          const SizedBox(
            width: 6,
          )
        ],
      ),
      body: ValueListenableBuilder(
        valueListenable: todoBox.listenable(),
        builder: (context, Box<HiveTodoModel> box, _) {
          if (box.values.isEmpty) {
            return const Center(
              child: Text(
                "No todos available!",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
            );
          }

          return ListView.separated(
            itemBuilder: (context, index) {
              var todo = box.getAt(index);
              return ListTile(
                leading: Icon(
                  todo?.todoType == 'Urgent'
                      ? Icons.check_circle_outline_outlined
                      : Icons.pending_actions_sharp,
                  color: todo?.todoType == 'Urgent' ? Colors.red : Colors.green,
                  size: 35,
                ),
                title: Text(
                  todo?.todoHeading ?? '',
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w600),
                ),
                subtitle: Text(
                  todo!.todoDescription!,
                  style: const TextStyle(fontSize: 16),
                ),
                trailing: IconButton(
                  icon: const Icon(
                    Icons.delete_outlined,
                    size: 30,
                    color: Colors.red,
                  ),
                  onPressed: () {
                    deleteTodoAt(index);
                  },
                ),
              );
            },
            separatorBuilder: (context, index) => const Divider(),
            itemCount: box.length,
          );
        },
      ),
      floatingActionButton: const FloatingActionButtonPage(),
    );
  }

  void deleteTodoAt(int index) {
    todoBox.deleteAt(index);
  }

  void deleteAllTodos() {
    todoBox.clear();
  }
}
