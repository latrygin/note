class Task {
  int id;
  String text;
  TaskImportant important;
  DateTime? deadline;
  bool done;
  String? color;
  DateTime? createdAt;
  DateTime? changedAt;
  int? lastUpdatedBy;

  Task({
    required this.id,
    required this.text,
    this.important = TaskImportant.basic,
    this.deadline,
    this.done = false,
    this.color,
    this.createdAt,
    this.changedAt,
    this.lastUpdatedBy,
  });
}

enum TaskImportant {
  basic,
  low,
  important,
}
