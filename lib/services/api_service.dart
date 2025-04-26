import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/task_model.dart';

class ApiService {
  static const String baseUrl =
      'http://3.87.225.64:5000/api/tasks'; // Use your IP if testing on device

  Future<List<TaskModel>> getTasks() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((task) => TaskModel.fromJson(task)).toList();
    } else {
      throw Exception('Failed to load tasks');
    }
  }

  Future<TaskModel> createTask(String title) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'title': title}),
    );

    if (response.statusCode == 201) {
      return TaskModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to create task');
    }
  }

  Future<void> toggleTaskCompletion(String id, bool isCompleted) async {
    final url = '$baseUrl/$id';
    final response = await http.put(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'isCompleted': isCompleted}),
    );
    if (response.statusCode != 200) throw Exception('Failed to update task');
  }

  Future<void> deleteTask(String id) async {
    final url = '$baseUrl/$id';
    final response = await http.delete(Uri.parse(url));
    if (response.statusCode != 200) throw Exception('Failed to delete task');
  }
}
