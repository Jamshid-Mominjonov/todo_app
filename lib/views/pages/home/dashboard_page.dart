import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/route/route_names.dart';
import '../../../models/task_model.dart';
import '../../../view_models/riverpod.dart';
import '../../widgets/home/task_button.dart';
import '../../widgets/home/task_text_field.dart';
import '../../widgets/home/view_tasks_button.dart';

class DashboardPage extends ConsumerStatefulWidget {
  const DashboardPage({super.key});

  @override
  ConsumerState<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends ConsumerState<DashboardPage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    final tasksProvider = ref.read(taskNotifierProvider.notifier);
    return Scaffold(
      backgroundColor: Color(0xffF2F2F2),
      body: Column(
        children: [
          Container(
            height: screenHeight * 0.3,
            color: Colors.lightBlueAccent,
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
                left: screenWidth * 0.04,
                right: screenWidth * 0.04,
                top: screenHeight * 0.02,
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                      Text(
                        "Manage your tasks",
                        style: TextStyle(
                          fontSize: 30,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    Text(
                      "Stay organized effortlessly",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                      ),
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
                                padding: EdgeInsets.only(top: screenHeight * 0.02, left: screenWidth * 0.04, right: screenWidth * 0.04),
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
                                      TaskTextField(controller: titleController, hintText: 'Title'),
                                      SizedBox(height: screenHeight * 0.01),
                                      TaskTextField(controller: descriptionController, hintText: 'Description'),
                                      SizedBox(height: screenHeight * 0.01),
                                      TaskButton(text: 'Create Task', onPressed: () {
                                        final newTask = Task(title: titleController.text.trim(), description: descriptionController.text.trim());
                                        tasksProvider.addTask(newTask);
                                        titleController.clear();
                                        descriptionController.clear();
                                        Navigator.pop(context);
                                        ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(
                                              behavior: SnackBarBehavior.floating,
                                            margin: EdgeInsets.all(4),
                                              content: Text(
                                                textAlign: TextAlign.center,
                                                'Task created successfully',
                                                style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.white,
                                                 ),
                                              ),
                                              duration: Duration(seconds: 2),
                                              backgroundColor: Color(0xff62D2C3),
                                            ),
                                        );
                                      }
                                      ),
                                    ]
                                ),
                              );
                            },
                          );
                        }
                        ),
                    SizedBox(height: screenHeight * 0.01),
                    ViewTasksButton(text: 'View tasks', onPressed: () => Navigator.pushNamed(context, RouteNames.taskPage),
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
