import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../models/task_model.dart';
import '../../providers/task_provider.dart';
import '../widgets/task_button.dart';
import '../widgets/task_priority.dart';
import '../widgets/task_text_field.dart';

class TaskPage extends StatefulWidget {
  const TaskPage({super.key});

  @override
  State<TaskPage> createState() => _TasksPageState();
}

class _TasksPageState extends State<TaskPage> {
  Priority selectedPriority = Priority.low;
  Priority editSelectedPriority = Priority.low;

  final TextEditingController newTitleController = TextEditingController();
  final TextEditingController newDescriptionController = TextEditingController();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      if (!mounted) return;
      context.read<TaskProvider>().loadTasks();
    });
  }

  @override
  void dispose() {
    newTitleController.dispose();
    newDescriptionController.dispose();
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  Color priorityColor(Priority priority) {
    switch (priority) {
      case Priority.high:
        return const Color(0xff0D9E6E);
      case Priority.medium:
        return const Color(0xffB45309);
      case Priority.low:
        return const Color(0xffB91C1C);
    }
  }

  String priorityLabel(Priority priority) {
    switch (priority) {
      case Priority.high:   return 'High';
      case Priority.medium: return 'Medium';
      case Priority.low:    return 'Low';
    }
  }

  Widget buildPriority(Priority priority) {
    final color = priorityColor(priority);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: color.withValues(alpha: 0.4)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            priorityLabel(priority),
            style: TextStyle(
              fontSize: 10.sp,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF2F2F2),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0096C8),
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 24.w),
        ),
        title: Text(
          'Task List',
          style: TextStyle(
            fontSize: 24.sp,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Consumer<TaskProvider>(
        builder: (context, provider, child) {
          final tasks = provider.tasks;
          if (tasks.isEmpty) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'No tasks yet',
                    style: TextStyle(fontSize: 18.sp, color: Colors.grey),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              final task = tasks[index];
              return Container(
                margin: EdgeInsets.only(bottom: 10.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.r),
                  color: Colors.white,
                  border: Border(
                    left: BorderSide(
                      color: priorityColor(task.priority),
                      width: 4,
                    ),
                  ),
                ),
                child: ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
                  leading: IconButton(
                    onPressed: () => provider.toggleTask(index),
                    icon: Icon(
                      task.isDone
                          ? Icons.check_circle_rounded
                          : Icons.circle_outlined,
                      color: task.isDone
                          ? const Color(0xFF0096C8)
                          : Colors.grey,
                      size: 28.w,
                    ),
                  ),
                  title: Text(
                    task.title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.sp,
                      decoration: task.isDone
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                      color: task.isDone ? Colors.grey : Colors.black,
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (task.description.isNotEmpty) ...[
                        SizedBox(height: 2.h),
                        Text(
                          task.description,
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.grey[600],
                            decoration: task.isDone
                                ? TextDecoration.lineThrough
                                : TextDecoration.none,
                          ),
                        ),
                      ],
                      SizedBox(height: 6.h),
                      buildPriority(task.priority),
                      SizedBox(height: 4.h),
                    ],
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit, color: Colors.grey, size: 22.w),
                        onPressed: () {
                          newTitleController.text = task.title;
                          newDescriptionController.text = task.description;
                          editSelectedPriority = task.priority;
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(20.r),
                              ),
                            ),
                            builder: (context) {
                              return StatefulBuilder(
                                builder: (context, setModalState) {
                                  return Padding(
                                    padding: EdgeInsets.only(
                                      top: 20.h,
                                      left: 20.w,
                                      right: 20.w,
                                      bottom: MediaQuery.of(context).viewInsets.bottom + 20.h,
                                    ),
                                    child: SingleChildScrollView(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Container(
                                            width: 40.w,
                                            height: 4.h,
                                            decoration: BoxDecoration(
                                              color: Colors.grey[300],
                                              borderRadius: BorderRadius.circular(2.r),
                                            ),
                                          ),
                                          SizedBox(height: 16.h),
                                          Text(
                                            'Update Task',
                                            style: TextStyle(
                                              fontSize: 20.sp,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.black,
                                            ),
                                          ),
                                          SizedBox(height: 20.h),
                                          TaskTextField(
                                            controller: newTitleController,
                                            hintText: 'Title',
                                          ),
                                          SizedBox(height: 16.h),
                                          TaskTextField(
                                            controller: newDescriptionController,
                                            hintText: 'Description',
                                          ),
                                          SizedBox(height: 20.h),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Expanded(
                                                child: TaskPriority(
                                                  color: editSelectedPriority == Priority.high
                                                      ? const Color(0xff0D9E6E).withValues(alpha: 0.2)
                                                      : const Color(0xffE8FDF5),
                                                  txt: 'High',
                                                  onPressed: () {
                                                    setModalState(() {
                                                      editSelectedPriority = Priority.high;
                                                    });
                                                  },
                                                  textColor: const Color(0xff0D9E6E),
                                                  borderColor: editSelectedPriority == Priority.high
                                                      ? const Color(0xff0D9E6E)
                                                      : const Color(0xFFB3F0DA),
                                                ),
                                              ),
                                              Expanded(
                                                child: TaskPriority(
                                                  color: editSelectedPriority == Priority.medium
                                                      ? const Color(0xffB45309).withValues(alpha: 0.2)
                                                      : const Color(0xffFFF8E6),
                                                  txt: 'Medium',
                                                  onPressed: () {
                                                    setModalState(() {
                                                      editSelectedPriority = Priority.medium;
                                                    });
                                                  },
                                                  textColor: const Color(0xffB45309),
                                                  borderColor: editSelectedPriority == Priority.medium
                                                      ? const Color(0xffB45309)
                                                      : const Color(0xFFFDE68A),
                                                ),
                                              ),
                                              Expanded(
                                                child: TaskPriority(
                                                  color: editSelectedPriority == Priority.low
                                                      ? const Color(0xffB91C1C).withValues(alpha: 0.2)
                                                      : const Color(0xFFFEF2F2),
                                                  txt: 'Low',
                                                  onPressed: () {
                                                    setModalState(() {
                                                      editSelectedPriority = Priority.low;
                                                    });
                                                  },
                                                  textColor: const Color(0xffB91C1C),
                                                  borderColor: editSelectedPriority == Priority.low
                                                      ? const Color(0xffB91C1C)
                                                      : const Color(0xFFFECACA),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 24.h),
                                          TaskButton(
                                            text: 'Update Task',
                                            onPressed: () async {
                                              final messenger = ScaffoldMessenger.of(context);
                                              final navigator = Navigator.of(context);
                                              final updatedTask = Task(
                                                title: newTitleController.text.trim(),
                                                description: newDescriptionController.text.trim(),
                                                isDone: task.isDone,
                                                priority: editSelectedPriority,
                                              );
                                              await context.read<TaskProvider>().updateTask(
                                                index,
                                                updatedTask,
                                              );
                                              newTitleController.clear();
                                              newDescriptionController.clear();
                                              navigator.pop();
                                              messenger.showSnackBar(
                                                SnackBar(
                                                  behavior: SnackBarBehavior.floating,
                                                  margin: EdgeInsets.all(16.w),
                                                  content: Text(
                                                    'Task updated successfully',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(fontSize: 14.sp, color: Colors.white),
                                                  ),
                                                  duration: const Duration(seconds: 2),
                                                  backgroundColor: const Color(0xFF0096C8),
                                                ),
                                              );
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                          );
                        },
                      ),
                      IconButton(
                        onPressed: () async {
                          await context.read<TaskProvider>().deleteTask(index);
                        },
                        icon: Icon(Icons.delete, color: Colors.red, size: 22.w),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.transparent,
        elevation: 0,
        highlightElevation: 0,
        child: Icon(
          Icons.add_circle_rounded,
          color: const Color(0xFF0096C8),
          size: 56.sp,
        ),
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
            ),
            builder: (context) {
              return StatefulBuilder(
                builder: (context, setModalState) {
                  return Padding(
                    padding: EdgeInsets.only(
                      top: 20.h,
                      left: 20.w,
                      right: 20.w,
                      bottom: MediaQuery.of(context).viewInsets.bottom + 20.h,
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 40.w,
                            height: 4.h,
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(2.r),
                            ),
                          ),
                          SizedBox(height: 16.h),
                          Text(
                            'New Task',
                            style: TextStyle(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: 20.h),
                          TaskTextField(
                            controller: titleController,
                            hintText: 'Title',
                          ),
                          SizedBox(height: 16.h),
                          TaskTextField(
                            controller: descriptionController,
                            hintText: 'Description',
                          ),
                          SizedBox(height: 20.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TaskPriority(
                                color: selectedPriority == Priority.high
                                    ? const Color(0xff0D9E6E).withValues(alpha: 0.2)
                                    : const Color(0xffE8FDF5),
                                txt: 'High',
                                onPressed: () {
                                  setModalState(() {
                                    selectedPriority = Priority.high;
                                  });
                                },
                                textColor: const Color(0xff0D9E6E),
                                borderColor: selectedPriority == Priority.high
                                    ? const Color(0xff0D9E6E)
                                    : const Color(0xFFB3F0DA),
                              ),
                              TaskPriority(
                                color: selectedPriority == Priority.medium
                                    ? const Color(0xffB45309).withValues(alpha: 0.2)
                                    : const Color(0xffFFF8E6),
                                txt: 'Medium',
                                onPressed: () {
                                  setModalState(() {
                                    selectedPriority = Priority.medium;
                                  });
                                },
                                textColor: const Color(0xffB45309),
                                borderColor: selectedPriority == Priority.medium
                                    ? const Color(0xffB45309)
                                    : const Color(0xFFFDE68A),
                              ),
                              TaskPriority(
                                color: selectedPriority == Priority.low
                                    ? const Color(0xffB91C1C).withValues(alpha: 0.2)
                                    : const Color(0xFFFEF2F2),
                                txt: 'Low',
                                onPressed: () {
                                  setModalState(() {
                                    selectedPriority = Priority.low;
                                  });
                                },
                                textColor: const Color(0xffB91C1C),
                                borderColor: selectedPriority == Priority.low
                                    ? const Color(0xffB91C1C)
                                    : const Color(0xFFFECACA),
                              ),
                            ],
                          ),
                          SizedBox(height: 24.h),
                            TaskButton(
                              text: 'Create Task',
                              onPressed: () async {
                                final title = titleController.text.trim();
                                final description = descriptionController.text
                                    .trim();
                                if (title.isEmpty) return;
                                final messenger = ScaffoldMessenger.of(context);
                                final navigator = Navigator.of(context);
                                final newTask = Task(
                                  title: title,
                                  description: description,
                                  isDone: false,
                                  priority: selectedPriority,
                                );
                                await context.read<TaskProvider>().addTask(
                                    newTask);
                                titleController.clear();
                                descriptionController.clear();
                                setState(() => selectedPriority = Priority.low);
                                navigator.pop();
                                messenger.showSnackBar(
                                  SnackBar(
                                    behavior: SnackBarBehavior.floating,
                                    margin: EdgeInsets.all(16.w),
                                    content: Text(
                                      'Task created successfully',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 14.sp, color: Colors.white),
                                    ),
                                    duration: const Duration(seconds: 2),
                                    backgroundColor: const Color(0xFF0096C8),
                                  ),
                                );
                              },
                            ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}