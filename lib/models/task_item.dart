import 'dart:convert';

enum Importance {
  later,
  ongoing,
  running,
  urgent,
}

class TaskItem {
  String? cTaskId;
  final String title;
  final String taskDescription;
  final Importance category;
  final String dateTime;
  DateTime? date;
  final bool isComplete;

  TaskItem({
    this.cTaskId,
    required this.title,
    required this.taskDescription,
    required this.category,
    required this.dateTime,
    this.date,
    this.isComplete = false,
  });

  TaskItem copyWith({
    String? cTaskId,
    String? title,
    String? taskDescription,
    Importance? category,
    String? dateTime,
    DateTime? date,
    bool? isComplete,
  }) {
    return TaskItem(
      cTaskId: cTaskId ?? this.cTaskId,
      title: title ?? this.title,
      taskDescription: taskDescription ?? this.taskDescription,
      category: category ?? this.category,
      dateTime: dateTime ?? this.dateTime,
      date: date ?? this.date,
      isComplete: isComplete ?? this.isComplete,
    );
  }

  factory TaskItem.fromMap(Map<String, dynamic> json) => TaskItem(
    cTaskId: json['cTaskId'],
    title: json['title'],
    taskDescription: json['taskDescription'],
    category: json['category'],
    dateTime: json['dateTime'],
  );

  static Map<String, dynamic> toMap(TaskItem taskItem) {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['cTaskId'] = taskItem.cTaskId;
    data['title'] = taskItem.title;
    data['taskDescription'] = taskItem.taskDescription;
    data['category'] = taskItem.category;
    data['dateTime'] = taskItem.dateTime;

    return data;
  }

  static String encode(List<TaskItem> taskItems) => json.encode(
    taskItems.map<Map<String, dynamic>>((taskItem) => TaskItem.toMap(taskItem)).toList(),
  );

  static List<TaskItem> decode(String taskItems) => (json.decode(taskItems) as List<dynamic>).map<TaskItem>((item) => TaskItem.fromMap(item)).toList();
}