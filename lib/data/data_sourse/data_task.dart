import 'package:hive/hive.dart';

part 'data_task.g.dart';

@HiveType(typeId: 0)
class Task extends HiveObject {
  @HiveField(0)
  String title;
  @HiveField(1)
  String description;

  Task({required this.title, required this.description});
}