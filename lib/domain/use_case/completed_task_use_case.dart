import '../entities/tasks_entities.dart';
import '../repositories/task_repositories.dart';

class CompletedTaskUseCase {
  final TaskRepositories taskRepositories;

  CompletedTaskUseCase({required this.taskRepositories});

  Future<void> call (String id, TasksEntities tasksEntities) async {
    return await taskRepositories.completedTask(id, tasksEntities);
  }

}