import 'package:flutter/material.dart';
import '../widgets/add_task_bottom_sheet.dart';
import '../models/task.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<MyTask> tasks = [];

  void _addTask(MyTask task) {
    setState(() {
      tasks.add(task);
    });
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body:
          tasks.isEmpty
              ? Center(child: Text("No Tasks"))
              : ListView.builder(
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Checkbox(
                      value: tasks[index].isCompleted,
                      onChanged: (value) {
                        setState(() {
                          tasks[index].isCompleted = value!;
                        });
                      },
                    ),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          tasks[index].title,
                          style: TextStyle(
                            fontSize: 20,
                            decoration:
                                tasks[index].isCompleted
                                    ? TextDecoration.lineThrough
                                    : null,
                          ),
                        ),
                        Text(
                          tasks[index].description,
                          style: TextStyle(
                            fontSize: 16,
                            decoration:
                                tasks[index].isCompleted
                                    ? TextDecoration.lineThrough
                                    : null,
                            color: (Colors.grey),
                          ),
                        ),
                      ],
                    ),

                    trailing: IconButton(
                      onPressed: () {
                        setState(() {
                          tasks.removeAt(index);
                        });
                      },
                      icon: Icon(
                        Icons.remove_circle_outline,
                        color: Colors.red,
                      ),
                    ),
                  );
                },
              ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showAddTaskBottomSheet(context, _addTask);
        },
        label: Text("New Task"),
        icon: Icon(Icons.add),
        backgroundColor: (Colors.blue[100]),
      ),
    );
  }
}
