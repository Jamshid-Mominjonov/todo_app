import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/route/route_names.dart';
import '../../../models/task_model.dart';
import '../../../view_models/riverpod.dart';
import '../../../view_models/task/task_view_model.dart';
import '../../widgets/home/task_button.dart';
import '../../widgets/home/task_text_field.dart';

class TaskPage extends ConsumerStatefulWidget {
  const TaskPage({super.key});

  @override
  ConsumerState<TaskPage> createState() => _TasksPageState();
}

class _TasksPageState extends ConsumerState<TaskPage> {
  TextEditingController newTitleController = TextEditingController();
  TextEditingController newDescriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(taskNotifierProvider.notifier).getTasks();
    });
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    final state = ref.watch(taskNotifierProvider);
    final tasksProvider = ref.read(taskNotifierProvider.notifier);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back, color: Colors.white),
        ),
        title: Text(
          'Task List',
          style: TextStyle(
            fontSize: 24,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(onPressed: (){
              ref.read(signOutNotifierProvider.notifier).signOut();
              Navigator.pushNamed(context, RouteNames.signInPage);
              },
            icon: Icon(Icons.logout_outlined, color: Colors.white),
          ),
        ],
      ),
      body: Builder(
        builder: (context) {
          if (state is TaskLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is TaskSuccess) {
            if (state.task.isEmpty) {
              return const Center(child: Text('No tasks'));
            }
            return Container(
              color: Color(0xffF2F2F2),
              child: ListView.builder(
                itemCount: state.task.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.white,
                    ),
                    child: ListTile(
                      title: Text(
                        state.task[index].title,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        state.task[index].description,
                        style: TextStyle(fontSize: 16),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.edit, color: Colors.grey),
                            onPressed: () {
                              newTitleController.text = state.task[index].title;
                              newDescriptionController.text = state.task[index].description;
                              showModalBottomSheet(
                                context: context,
                                builder: (context) {
                                  return Padding(
                                    padding: EdgeInsets.only(
                                      top: screenHeight * 0.02,
                                      left: screenWidth * 0.04,
                                      right: screenWidth * 0.04,
                                    ),
                                    child: Column(
                                      children: [
                                        Text(
                                          'Update Task',
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black,
                                          ),
                                        ),
                                        SizedBox(height: screenHeight * 0.01),
                                        TaskTextField(
                                          controller: newTitleController,
                                          hintText: 'Title',
                                        ),
                                        SizedBox(height: screenHeight * 0.01),
                                        TaskTextField(
                                          controller: newDescriptionController,
                                          hintText: 'Description',
                                        ),
                                        SizedBox(height: screenHeight * 0.01),
                                        TaskButton(
                                          text: 'Update Task',
                                          onPressed: () {
                                            final updateTask = Task(
                                              title: newTitleController.text.trim(),
                                              description: newDescriptionController.text.trim(),
                                            );
                                            tasksProvider.updateTask(
                                              index,
                                              updateTask,
                                            );
                                            newTitleController.clear();
                                            newDescriptionController.clear();
                                            Navigator.pop(context);
                                            ScaffoldMessenger.of(
                                              context,
                                            ).showSnackBar(
                                              SnackBar(
                                                behavior:
                                                    SnackBarBehavior.floating,
                                                margin: EdgeInsets.all(16),
                                                content: Text(
                                                  textAlign: TextAlign.center,
                                                  'Task updated successfully',
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                duration: Duration(seconds: 2),
                                                backgroundColor: Colors.lightBlueAccent,
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
                          IconButton(
                            onPressed: () {
                              tasksProvider.deleteTask(index);
                            },
                            icon: Icon(Icons.delete, color: Colors.red),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          } else if (state is TaskError) {
            return Center(child: Text(state.message));
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
