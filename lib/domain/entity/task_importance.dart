import 'package:hive/hive.dart';

part 'task_importance.g.dart';

@HiveType(typeId: 2)
enum TaskImportant {
  @HiveField(0)
  basic,
  @HiveField(1)
  low,
  @HiveField(2)
  important,
}
