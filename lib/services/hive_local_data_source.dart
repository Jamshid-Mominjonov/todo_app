import 'package:hive/hive.dart';
import '../models/task_model.dart';

class HiveLocalDataSource {
  Box<Task> get _box => Hive.box<Task>('taskBox');

  Future<void> addTask(Task task) async {
    await _box.add(task);
  }

  Future<List<Task>> getTasks() async {
    return _box.values.toList();
  }

  Future<void> updateTask(int index, Task newTask) async {
    await _box.putAt(index, newTask);
  }

  Future<void> deleteTask(int index) async {
    await _box.deleteAt(index);
  }
}