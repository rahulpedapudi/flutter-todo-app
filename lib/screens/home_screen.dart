import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/widgets/task_provider.dart';
import '../widgets/add_task_bottom_sheet.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    var taskProvider = Provider.of<TaskProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body:
          taskProvider.tasks.isEmpty
              ? Center(child: Text("No Tasks"))
              : ListView.builder(
                itemCount: taskProvider.tasks.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Checkbox(
                      value: taskProvider.tasks[index].isCompleted,
                      onChanged: (value) {
                        taskProvider.toggleTaskCompletion(index);
                      },
                    ),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          taskProvider.tasks[index].title,
                          style: TextStyle(
                            fontSize: 20,
                            decoration:
                                taskProvider.tasks[index].isCompleted
                                    ? TextDecoration.lineThrough
                                    : null,
                          ),
                        ),
                        Text(
                          taskProvider.tasks[index].description,
                          style: TextStyle(
                            fontSize: 16,
                            decoration:
                                taskProvider.tasks[index].isCompleted
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
                          taskProvider.tasks.removeAt(index);
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
          showAddTaskBottomSheet(context);
        },
        label: Text("New Task"),
        icon: Icon(Icons.add),
        backgroundColor: (Colors.blue[100]),
      ),
    );
  }
}
