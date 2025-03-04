import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/models/task.dart';
import 'package:todo_app/widgets/task_provider.dart';

void showAddTaskBottomSheet(BuildContext context) {
  String taskTitle = "";
  String taskDesc = "";

  showModalBottomSheet(
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    isScrollControlled:
        true, // Ensures it adapts to keyboard when input fields are used
    builder: (context) {
      return Padding(
        padding: EdgeInsets.only(
          left: 16,
          right: 16,
          bottom: MediaQuery.of(context).viewInsets.bottom + 16,
          top: 16,
        ),
        child: Wrap(
          children: [
            Text(
              "Add New Task",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 50),
            TextField(
              onChanged: (value) {
                taskTitle = (value);
              },
              autofocus: true,
              decoration: InputDecoration(
                labelText: "e.g., Organize family photos",
              ),
            ),
            SizedBox(height: 60),
            TextField(
              onChanged: (value) {
                taskDesc = (value);
              },
              decoration: InputDecoration(
                labelText: "Description",
                labelStyle: TextStyle(fontSize: 14),
              ),
            ),
            SizedBox(height: 70),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FilledButton(
                  style: TextButton.styleFrom(backgroundColor: Colors.blue),
                  onPressed: () {
                    if (taskTitle.isNotEmpty) {
                      Provider.of<TaskProvider>(context, listen: false).addTask(
                        MyTask(
                          title: taskTitle,
                          description: taskDesc,
                          isCompleted: false,
                        ),
                      );
                      Navigator.pop(context);
                    }
                  },
                  child: Text("Save Task"),
                ),
              ],
            ),
          ],
        ),
      );
    },
  );
}
