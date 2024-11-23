import 'package:app_task/domain/entities/tasks_entities.dart';

import '../repositories/task_repositories.dart';

class AddTaskUseCase {
  final TaskRepositories taskRepositories;

  AddTaskUseCase({required this.taskRepositories});

  Future<void> call(TasksEntities tasksEntities) async {
    await taskRepositories.addTask(tasksEntities);
  }
}
