import 'package:flutter/material.dart';
import 'package:todo_app/models/task.dart';

class TaskProvider with ChangeNotifier {
  final List<MyTask> _tasks = [];
  List<MyTask> get tasks => _tasks;
  int get taskCount => _tasks.length;

  void addTask(MyTask task) {
    _tasks.add(task);
    notifyListeners();
  }

  void removeTask(int index) {
    _tasks.removeAt(index);
    notifyListeners();
  }

  void toggleTaskCompletion(int index) {
    _tasks[index].isCompleted = !_tasks[index].isCompleted;
    notifyListeners();
  }

  int completedTasks() {
    return _tasks.where((task) => task.isCompleted).length;
  }
}
