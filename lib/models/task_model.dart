import 'package:hive/hive.dart';

part 'task.g.dart';

@HiveType(typeId: 0)
class Task extends HiveObject {
  @HiveField(0)
  String title;

  @HiveField(1)
  String description;

  @HiveField(2)
  bool isDone;

  @HiveField(3)
  Priority priority;

  Task({
    required this.title,
    required this.description,
    required this.isDone,
    this.priority = Priority.low,
  });
}

@HiveType(typeId: 1)
enum Priority {
  @HiveField(0)
  low,

  @HiveField(1)
  medium,

  @HiveField(2)
  high,
}