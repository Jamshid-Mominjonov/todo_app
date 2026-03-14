import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/task_model.dart';
import '../../providers/task_provider.dart';
import '../widgets/task_button.dart';
import '../widgets/task_text_field.dart';

class TaskPage extends StatefulWidget {
  const TaskPage({super.key});

  @override
  State<TaskPage> createState() => _TasksPageState();
}

class _TasksPageState extends State<TaskPage> {
  final TextEditingController newTitleController = TextEditingController();
  final TextEditingController newDescriptionController = TextEditingController();

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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<TaskProvider>();
    final tasks = provider.tasks;
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff62D2C3),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back, color: Colors.white),
        ),
        title: const Text(
          'Task List',
          style: TextStyle(
            fontSize: 24,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: tasks.isEmpty
          ? const Center(child: Text('No tasks'))
          : Container(
        color: const Color(0xffF2F2F2),
        child: ListView.builder(
          itemCount: tasks.length,
          itemBuilder: (context, index) {
            return Container(
              margin: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.white,
              ),
              child: ListTile(
                title: Text(
                  tasks[index].title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  tasks[index].description,
                  style: const TextStyle(fontSize: 16),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit, color: Colors.grey),
                      onPressed: () {
                        newTitleController.text = tasks[index].title;
                        newDescriptionController.text = tasks[index].description;
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          builder: (context) {
                            return Padding(
                              padding: EdgeInsets.only(
                                top: screenHeight * 0.02,
                                left: screenWidth * 0.04,
                                right: screenWidth * 0.04,
                                  bottom: MediaQuery.of(context).viewInsets.bottom + 20
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Text(
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
                                    onPressed: () async {
                                      final messenger = ScaffoldMessenger.of(context);
                                      final navigator = Navigator.of(context);
                                      final updateTask = Task(
                                        title: newTitleController.text.trim(),
                                        description: newDescriptionController.text.trim(),
                                      );
                                      await context.read<TaskProvider>().updateTask(
                                        index,
                                        updateTask,
                                      );
                                      newTitleController.clear();
                                      newDescriptionController.clear();
                                      navigator.pop();
                                      messenger.showSnackBar(
                                        const SnackBar(
                                          behavior: SnackBarBehavior.floating,
                                          margin: EdgeInsets.all(16),
                                          content: Text(
                                            'Task updated successfully',
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
                    IconButton(
                      onPressed: () async {
                        await context.read<TaskProvider>().deleteTask(index);
                      },
                      icon: const Icon(Icons.delete, color: Colors.red),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}