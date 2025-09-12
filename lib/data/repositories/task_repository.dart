import 'package:todo_app/data/local/hive_local_data_source.dart';

import '../../models/task_model.dart';

class TaskRepository {
  HiveLocalDataSource hiveLocalDataSource;

  TaskRepository({required this.hiveLocalDataSource});

  Future<void> saveTask(Task task) async {
    return hiveLocalDataSource.addTask(task);
  }

  Future <List<Task>> getTask() async {
    return hiveLocalDataSource.getTasks();
  }

  Future<void> updateTask(int index, Task newTask) async {
    return hiveLocalDataSource.updateTask(index, newTask);
  }

  Future<void> deleteTask(int index) async {
    return hiveLocalDataSource.deleteTask(index);
  }
}