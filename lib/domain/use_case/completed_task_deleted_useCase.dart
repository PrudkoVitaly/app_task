import 'package:app_task/data/repositories_impl/task_repositories_impl.dart';

import '../repositories/task_repositories.dart';

class CompletedTaskDeletedUseCase {
  final TaskRepositories taskRepositories;

  CompletedTaskDeletedUseCase({required this.taskRepositories});

  Future<void> call(String id) async {
    await taskRepositories.completedTaskDelete(id);
  }
}