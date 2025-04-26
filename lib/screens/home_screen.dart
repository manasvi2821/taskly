// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import '../models/task_model.dart';
import '../services/api_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ApiService apiService = ApiService();
  List<TaskModel> tasks = [];
  TextEditingController taskController = TextEditingController();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchTasks();
  }

  Future<void> fetchTasks() async {
    setState(() => isLoading = true);
    try {
      final fetchedTasks = await apiService.getTasks();
      setState(() => tasks = fetchedTasks);
    } catch (e) {
      print('Error fetching tasks: $e');
    } finally {
      setState(() => isLoading = false);
    }
  }

  Future<void> addTask() async {
    final title = taskController.text.trim();
    if (title.isEmpty) return;

    try {
      final newTask = await apiService.createTask(title);
      setState(() {
        tasks.add(newTask);
        taskController.clear();
      });
    } catch (e) {
      print('Error adding task: $e');
    }
  }

  Future<void> toggleCompletion(TaskModel task) async {
    try {
      await apiService.toggleTaskCompletion(task.id, !task.isCompleted);
      setState(() {
        task.isCompleted = !task.isCompleted;
      });
    } catch (e) {
      print('Error updating task: $e');
    }
  }

  Future<void> deleteTask(String id) async {
    try {
      await apiService.deleteTask(id);
      setState(() {
        tasks.removeWhere((task) => task.id == id);
      });
    } catch (e) {
      print('Error deleting task: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Taskly 📝'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: taskController,
                    decoration: const InputDecoration(
                      hintText: 'Enter new task',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: addTask,
                  child: const Text('Add'),
                ),
              ],
            ),
          ),
          Expanded(
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : tasks.isEmpty
                    ? const Center(child: Text('No tasks yet 😴'))
                    : ListView.builder(
                        itemCount: tasks.length,
                        itemBuilder: (context, index) {
                          final task = tasks[index];
                          return ListTile(
                            title: Text(
                              task.title,
                              style: TextStyle(
                                decoration: task.isCompleted
                                    ? TextDecoration.lineThrough
                                    : TextDecoration.none,
                              ),
                            ),
                            leading: Checkbox(
                              value: task.isCompleted,
                              onChanged: (_) => toggleCompletion(task),
                            ),
                            trailing: IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () => deleteTask(task.id),
                            ),
                          );
                        },
                      ),
          ),
        ],
      ),
    );
  }
}
