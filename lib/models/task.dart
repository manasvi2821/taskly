// lib/models/task.dart
class Task {
  final String id;
  final String title;
  late final bool isCompleted;

  Task({required this.id, required this.title, this.isCompleted = false});

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['_id'],
      title: json['title'],
      isCompleted: json['isCompleted'],
    );
  }

  Map<String, dynamic> toJson() => {
        'title': title,
        'isCompleted': isCompleted,
      };
}
