import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/presentation/pages/task_page.dart';
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
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: const Color(0xffF2F2F2),
      body: Column(
        children: [
          Container(
            height: screenHeight * 0.3,
            color: Color(0xff62D2C3),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Image.asset('assets/images/shape2.png'),
                ),
                Image.asset('assets/images/clock.png'),
              ],
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(
                top: screenHeight * 0.02,
                left: screenWidth * 0.04,
                right: screenWidth * 0.04,
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const Text(
                      "Manage your tasks",
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Text(
                      "Stay organized effortlessly",
                      style: TextStyle(fontSize: 20, color: Colors.black),
                    ),
                    SizedBox(height: screenHeight * 0.01),
                    Image.asset('assets/images/todo2.png'),
                    SizedBox(height: screenHeight * 0.01),
                    TaskButton(
                      text: 'Create a new task',
                      onPressed: (){
                        showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return Padding(
                              padding: EdgeInsets.only(
                                  top: screenHeight * 0.02,
                                  left: screenWidth * 0.04,
                                  right: screenWidth * 0.04
                              ),
                              child: Column(
                                children: [
                                  Text(
                                    'New Task',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black,
                                    ),
                                  ),
                                  SizedBox(height: screenHeight * 0.01),
                                  TaskTextField(
                                    controller: titleController,
                                    hintText: 'Title',
                                  ),
                                  SizedBox(height: screenHeight * 0.01),
                                  TaskTextField(
                                    controller: descriptionController,
                                    hintText: 'Description',
                                  ),
                                  SizedBox(height: screenHeight * 0.01),
                                  TaskButton(
                                    text: 'Create Task',
                                    onPressed: () async {
                                      final title = titleController.text.trim();
                                      final description = descriptionController.text.trim();
                                      final messenger = ScaffoldMessenger.of(context);
                                      final navigator = Navigator.of(context);
                                      final newTask = Task(title: title, description: description);
                                      await context.read<TaskProvider>().addTask(newTask);
                                      titleController.clear();
                                      descriptionController.clear();
                                      navigator.pop();
                                      messenger.showSnackBar(
                                        const SnackBar(
                                          behavior: SnackBarBehavior.floating,
                                          margin: EdgeInsets.all(4),
                                          content: Text(
                                            'Task created successfully',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(fontSize: 15, color: Colors.white),
                                          ),
                                          duration: Duration(seconds: 2),
                                          backgroundColor: Color(0xff62D2C3),
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                    ),
                    SizedBox(height: screenHeight * 0.01),
                    ViewTasksButton(
                      text: 'View tasks',
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const TaskPage()),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
