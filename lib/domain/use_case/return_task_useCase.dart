import 'package:app_task/domain/repositories/task_repositories.dart';

import '../entities/tasks_entities.dart';

class ReturnTaskUseCase {
  final TaskRepositories taskRepositories;

  ReturnTaskUseCase(this.taskRepositories);

  Future<void> call (String id, TasksEntities tasksEntities) async {
    await taskRepositories.returnTask(id, tasksEntities);
  }
}