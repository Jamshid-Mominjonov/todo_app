import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/data/repositories/task_repository.dart';
import 'package:todo_app/models/task_model.dart';

abstract class TaskState {}

class TaskInitial extends TaskState {}

class TaskLoading extends TaskState {}

class TaskSuccess extends TaskState {
  final List<Task> task;

  TaskSuccess(this.task);
}

class TaskError extends TaskState {
   final String message;

   TaskError(this.message);
}

class TaskNotifier extends StateNotifier<TaskState> {
  final TaskRepository taskRepository;

  TaskNotifier({required this.taskRepository}) : super(TaskInitial());
  List <Task> tasks = [];

  Future<void> addTask(Task task) async {
    state = TaskInitial();
    try {
      await taskRepository.saveTask(task);
      final tasks = await taskRepository.getTask();
      state = TaskSuccess(tasks);
    } catch (e) {
      state = TaskError(e.toString());
    }
  }

  void getTasks() async {
    state = TaskInitial();
    try {
      final tasks = await taskRepository.getTask();
      state = TaskSuccess(tasks);
    } catch (e) {
      state = TaskError(e.toString());
    }
  }

  Future<void> updateTask(int index, newTask) async {
    state = TaskInitial();
    try {
      await taskRepository.updateTask(index, newTask);
      final tasks = await taskRepository.getTask();
      state = TaskSuccess(tasks);
    } catch (e) {
      state = TaskError(e.toString());
    }
  }

  Future<void> deleteTask(int index) async {
    state = TaskInitial();
    try {
      await taskRepository.deleteTask(index);
      final tasks = await taskRepository.getTask();
      state = TaskSuccess(tasks);
    } catch (e) {
      state = TaskError(e.toString());
    }
  }
}
