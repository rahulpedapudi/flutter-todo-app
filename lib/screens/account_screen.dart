import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/widgets/task_provider.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var taskProvider = Provider.of<TaskProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Account"),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Card(
            child: Column(
              children: [
                Text('Total Tasks', style: TextStyle(fontSize: 28)),
                Text(
                  "${taskProvider.taskCount}",
                  style: TextStyle(fontSize: 28),
                ),
              ],
            ),
          ),
          SizedBox(height: 50),
          Card(
            child: Column(
              children: [
                Text('Completed Tasks', style: TextStyle(fontSize: 28)),
                Text(
                  '${taskProvider.completedTasks()}',
                  style: TextStyle(fontSize: 28),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
