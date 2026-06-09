import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/presentation/pages/task_page.dart';
import 'package:todo_app/presentation/widgets/task_priority.dart';
import '../../models/task_model.dart';
import '../../providers/task_provider.dart';
import '../widgets/task_button.dart';
import '../widgets/task_text_field.dart';
import '../widgets/view_tasks_button.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  Priority selectedPriority = Priority.low;
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF2F2F2),
      body: Column(
        children: [
          Container(
            height: 240.h,
            width: double.infinity,
            color: const Color(0xFF0096C8),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 80.w),
                  child: Image.asset('assets/images/clock.png'),
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
            Column(
            children: [
            SizedBox(height: 20.h),
            Text(
              "Manage your tasks",
              style: TextStyle(
                fontSize: 28.sp,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.h),
                Text(
                  "Stay organized effortlessly",
                  style: TextStyle(fontSize: 16.sp, color: Colors.black),
                ),
        ],
      ),
                Padding(
                  padding: EdgeInsets.only(bottom: 30.h, left: 20.w, right: 20.w),
                  child: Column(
                    children: [
                      TaskButton(
                        text: 'Create a new task',
                        onPressed: () {
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
                                          SizedBox(height: 24.h),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Expanded(
                                                child: TaskPriority(
                                                  color: selectedPriority == Priority.high
                                                      ? Color(0xff0D9E6E).withValues(alpha: 0.2)
                                                      : Color(0xffE8FDF5),
                                                  txt: 'High',
                                                  onPressed: () {
                                                    setModalState(() {
                                                      selectedPriority = Priority.high;
                                                    });
                                                  },
                                                  textColor: Color(0xff0D9E6E),
                                                  borderColor: selectedPriority == Priority.high
                                                      ? Color(0xff0D9E6E)
                                                      : Color(0xFFB3F0DA),
                                                ),
                                              ),
                                              Expanded(
                                                child: TaskPriority(
                                                  color: selectedPriority == Priority.medium
                                                      ? Color(0xffB45309).withValues(alpha: 0.2)
                                                      : Color(0xffFFF8E6),
                                                  txt: 'Medium',
                                                  onPressed: () {
                                                    setModalState(() {
                                                      selectedPriority = Priority.medium;
                                                    });
                                                  },
                                                  textColor: Color(0xffB45309),
                                                  borderColor: selectedPriority == Priority.medium
                                                      ? Color(0xffB45309)
                                                      : Color(0xFFFDE68A),
                                                ),
                                              ),
                                              Expanded(
                                                child: TaskPriority(
                                                  color: selectedPriority == Priority.low
                                                      ? Color(0xffB91C1C).withValues(alpha: 0.2)
                                                      : Color(0xFFFEF2F2),
                                                  txt: 'Low',
                                                  onPressed: () {
                                                    setModalState(() {
                                                      selectedPriority = Priority.low;
                                                    });
                                                  },
                                                  textColor: Color(0xffB91C1C),
                                                  borderColor: selectedPriority == Priority.low
                                                      ? Color(0xffB91C1C)
                                                      : Color(0xFFFECACA),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 24.h),
                                          TaskButton(
                                            text: 'Create Task',
                                            onPressed: () async {
                                              final title =
                                              titleController.text.trim();
                                              final description =
                                              descriptionController.text.trim();
                                              final messenger =
                                              ScaffoldMessenger.of(context);
                                              final navigator = Navigator.of(
                                                context,
                                              );
                                              final newTask = Task(
                                                title: title,
                                                description: description,
                                                isDone: false,
                                                priority: selectedPriority,
                                              );
                                              await context
                                                  .read<TaskProvider>()
                                                  .addTask(newTask);
                                              titleController.clear();
                                              descriptionController.clear();
                                              navigator.pop();
                                              messenger.showSnackBar(
                                                SnackBar(
                                                  behavior:
                                                  SnackBarBehavior.floating,
                                                  margin: EdgeInsets.all(16.w),
                                                  content: Text(
                                                    'Task created successfully',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      fontSize: 14.sp,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  duration: const Duration(seconds: 2),
                                                  backgroundColor: const Color(0xFF0096C8),
                                                ),
                                              );
                                            },
                                          ),
                                          SizedBox(height: 10.h),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                          ).whenComplete(() {
                            setState(() {
                              selectedPriority = Priority.low;
                            });
                          });
                        },
                      ),
                      SizedBox(height: 16.h),
                      ViewTasksButton(
                        text: 'View tasks',
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => const TaskPage()),
                          );
                        },
                      ),
                      SizedBox(height: 20.h),
                    ],
                  ),
                ),
          ],
          ),
          ),
        ],
      ),
    );
  }
}
