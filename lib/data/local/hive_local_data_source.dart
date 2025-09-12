import 'package:hive/hive.dart';
import 'package:todo_app/models/task_model.dart';

class HiveLocalDataSource {
  late Box<Task> box;

  HiveLocalDataSource() {
  box = Hive.box<Task>('taskBox');
}

  Future<void> addTask(Task task) async {
    await box.add(task);
  }

  Future <List<Task>> getTasks() async {
    return box.values.toList();
  }

  Future<void> updateTask(int index, Task newTask) async {
    await box.putAt(index, newTask);
  }

  Future<void> deleteTask(int index) async {
    await box.deleteAt(index);
  }
}