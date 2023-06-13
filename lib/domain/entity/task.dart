class Task {
  final String title;
  final DateTime? date;
  final TaskPriority priority;
  final bool isDone;

  Task({
    required this.title,
    this.date,
    this.priority = TaskPriority.none,
    this.isDone = false,
  });

  Task copyWith({
    String? title,
    DateTime? date,
    TaskPriority? priority,
    bool? isDone,
  }) {
    return Task(
      title: title ?? this.title,
      date: date ?? this.date,
      priority: priority ?? this.priority,
      isDone: isDone ?? this.isDone,
    );
  }
}

enum TaskPriority {
  none,
  low,
  high,
}
