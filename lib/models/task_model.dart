class TaskModel {
  final String id;
  final String title;
  late final bool isCompleted;

  TaskModel({required this.id, required this.title, required this.isCompleted});

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json['_id'],
      title: json['title'],
      isCompleted: json['isCompleted'],
    );
  }
}
