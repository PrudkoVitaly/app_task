import 'package:app_task/domain/entities/tasks_entities.dart';

abstract class TaskRepositories {

  Future<List<TasksEntities>> getTask();

  Future<void> addTask(TasksEntities tasksEntities);

  Future<void> completedTask(String id, TasksEntities tasksEntities);

  Future<void> deleteTask(String id);

  Future<void> completedTaskDelete(String id);

  Future<void> returnTask(String id, TasksEntities tasksEntities);



}