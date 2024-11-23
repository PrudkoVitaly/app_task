import 'package:app_task/data/data_sourse/task_date_source.dart';
import 'package:app_task/domain/repositories/task_repositories.dart';
import 'package:app_task/domain/use_case/add_task_useCase.dart';
import 'package:app_task/domain/use_case/get_task_useCase.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

import 'data/model/task_model.dart';
import 'data/repositories_impl/task_repositories_impl.dart';

// Управление зависимостями
// Service Locator
final GetIt sl = GetIt.instance;

Future<void> setUpServiceLocator() async {
  await Hive.initFlutter();
  Hive.registerAdapter(TaskModelAdapter());

  final _getTask = await Hive.openBox<TaskModel>('taskBox');

  sl.registerLazySingleton<TaskDateSource>(() => TaskDateSource(_getTask));

  sl.registerLazySingleton<TaskRepositories>(
    () => TaskRepositoriesImpl(
      taskDateSource: sl(),
    ),
  );

  sl.registerLazySingleton(
    () => GetTaskUseCase(
      taskRepositories: sl(),
    ),
  );

  sl.registerLazySingleton(
    () => AddTaskUseCase(
      taskRepositories: sl(),
    ),
  );
}

