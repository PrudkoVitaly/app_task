import '../entities/tasks_entities.dart';
import '../repositories/task_repositories.dart';

class DeleteTaskUseCase {
  final TaskRepositories taskRepositories;

  DeleteTaskUseCase({required this.taskRepositories});

  Future<void> call(String id) async {
    return await taskRepositories.deleteTask(id);
  }

}