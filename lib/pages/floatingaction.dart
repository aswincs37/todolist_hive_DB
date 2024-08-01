import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:todolist/models/hive_todo_model.dart';

class FloatingActionButtonPage extends StatefulWidget {
  const FloatingActionButtonPage({super.key});

  @override
  State<FloatingActionButtonPage> createState() =>
      _FloatingActionButtonPageState();
}

class _FloatingActionButtonPageState extends State<FloatingActionButtonPage> {
  late Box<HiveTodoModel> todoBox;
  final TextEditingController headingController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  int todoType = 1;

  @override
  void initState() {
    super.initState();
    todoBox = Hive.box<HiveTodoModel>('todo');
  }

  @override
  void dispose() {
    headingController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Colors.blue,
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              content: SizedBox(
                height: 350,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Add New ToDo",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: headingController,
                      decoration: InputDecoration(
                        hintText: "Add Todo title",
                        hintStyle: const TextStyle(fontWeight: FontWeight.w400),
                        filled: true,
                        fillColor: Colors.grey[200],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: descriptionController,
                      decoration: InputDecoration(
                        hintText: "Add Todo description...",
                        hintStyle: const TextStyle(fontWeight: FontWeight.w400),
                        filled: true,
                        fillColor: Colors.grey[200],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    const Text(
                      "ToDo Type",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildRadioButton("Urgent", 1, Colors.red),
                        _buildRadioButton("Not Urgent", 2, Colors.orange),
                      ],
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            onPressed: () {
                              writeData();
                              Navigator.of(context).pop();
                            },
                            icon: const Icon(
                              Icons.done,
                              color: Colors.white,
                            ),
                            label: const Text(
                              "Done",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          icon: const Icon(
                            Icons.close,
                            color: Colors.white,
                          ),
                          label: const Text(
                            "Cancel",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
      child: const Icon(
        Icons.add,
        size: 35,
        color: Colors.white,
      ),
    );
  }

  Widget _buildRadioButton(String label, int value, Color color) {
    return GestureDetector(
      onTap: () {
        setState(() {
          todoType = value;
        });
      },
      child: Row(
        children: [
          Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: color),
              color: todoType == value ? color : Colors.transparent,
            ),
            child: todoType == value
                ? const Icon(Icons.check, size: 16, color: Colors.white)
                : null,
          ),
          const SizedBox(width: 8),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  void writeData() {
    final title = headingController.text.trim();
    final description = descriptionController.text.trim();

    if (title.isNotEmpty && description.isNotEmpty) {
      final newTodo = HiveTodoModel(
        todoHeading: title,
        todoDescription: description,
        todoType: todoType == 1 ? 'Urgent' : 'Not Urgent',
        completedTask: false,
      );
      todoBox.add(newTodo);

      headingController.clear();
      descriptionController.clear();
    }
  }
}
