import 'package:app_task/data/model/task_model.dart';
import 'package:app_task/domain/entities/tasks_entities.dart';

import '../../domain/repositories/task_repositories.dart';
import '../data_sourse/task_date_source.dart';

class TaskRepositoriesImpl implements TaskRepositories {
  final TaskDateSource taskDateSource;

  TaskRepositoriesImpl({required this.taskDateSource});

  @override
  Future<void> addTask(TasksEntities tasksEntities) async {
    final taskModel = TaskModel(
      title: tasksEntities.title,
      color: tasksEntities.color,
      icon: tasksEntities.icon,
      date: tasksEntities.date,
      hour: tasksEntities.hour,
      minute: tasksEntities.minute,
      notes: tasksEntities.notes,
      id: tasksEntities.id,
    );
    await taskDateSource.addTask(taskModel);
  }

  @override
  Future<List<TasksEntities>> getTask() async {
    final task = await taskDateSource.getTask();
    return task
        .map((data) => TasksEntities(
              id: data.id,
              title: data.title,
              color: data.color,
              icon: data.icon,
              date: data.date,
              hour: data.hour,
              minute: data.minute,
              notes: data.notes,
            ))
        .toList();
  }
}
