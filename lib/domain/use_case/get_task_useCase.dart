import '../entities/tasks_entities.dart';
import '../repositories/task_repositories.dart';

class GetTaskUseCase {
  final TaskRepositories taskRepositories;

  GetTaskUseCase({required this.taskRepositories});

  Future<List<TasksEntities>> call () async {
    return await taskRepositories.getTask();
  }

}