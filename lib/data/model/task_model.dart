import 'package:app_task/domain/entities/tasks_entities.dart';
import 'package:hive/hive.dart';

part 'task_model.g.dart';

@HiveType(typeId: 0)
class TaskModel extends HiveObject {
  @HiveField(0)
  final String title;
  @HiveField(1)
  final int color;
  @HiveField(2)
  final String icon;
  @HiveField(3)
  final DateTime date;
  @HiveField(4)
  final int hour;
  @HiveField(5)
  final int minute;
  @HiveField(6)
  final String notes;
  @HiveField(7)
  bool isDone;
  @HiveField(8)
  final String id;


  TaskModel({
    required this.title,
    required this.color,
    required this.icon,
    required this.date,
    required this.hour,
    required this.minute,
    required this.notes,
    required this.id,
    this.isDone = false,
  });
}
