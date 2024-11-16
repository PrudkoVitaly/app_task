import 'package:app_task/domain/entities/tasks_entities.dart';

abstract class TaskRepositories {

  Future<List<TasksEntities>> getTask();

  Future<void> addTask(TasksEntities tasksEntities);

}