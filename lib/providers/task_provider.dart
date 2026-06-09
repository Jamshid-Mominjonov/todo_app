import 'package:flutter/material.dart';
import 'package:todo_app/services/hive_local_data_source.dart';

import '../models/task_model.dart';

class TaskProvider with ChangeNotifier {
      final HiveLocalDataSource dataSource;

      TaskProvider(this.dataSource);

      List<Task> _tasks = [];
      List<Task> get tasks => _tasks;

      Future<void> loadTasks() async {
        _tasks = await dataSource.getTasks();
        notifyListeners();
      }

      Future<void> addTask(Task task) async {
        await dataSource.addTask(task);
        await loadTasks();
      }

      Future<void> updateTask(int index, Task task) async {
        await dataSource.updateTask(index, task);
        await loadTasks();
      }

      Future<void> deleteTask(int index) async {
        await dataSource.deleteTask(index);
        await loadTasks();
      }

      Future<void> toggleTask(int index) async {
        final task = _tasks[index];
        task.isDone = !task.isDone;
        await dataSource.updateTask(index, task);
        await loadTasks();
      }

      Future<void> taskPriority(int index, Priority newPriority) async {
        final task = _tasks[index];
        task.priority = newPriority;
        await dataSource.updateTask(index, task);
        await loadTasks();
      }
}