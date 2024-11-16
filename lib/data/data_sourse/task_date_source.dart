import 'package:app_task/data/model/task_model.dart';
import 'package:hive/hive.dart';

class TaskDateSource {
  final String _taskBox = 'taskBox';

  Future<void> initHive() async {
    Hive.registerAdapter(
      TaskModelAdapter(),
    );
    await Hive.openBox<TaskModel>(_taskBox);
  }

  Box<TaskModel> _getTask() => Hive.box<TaskModel>(_taskBox);

  Future<List<TaskModel>> getTask() async {
    return _getTask().values.toList();
  }

  Future<void> addTask(TaskModel taskModel) async {
    return _getTask().put(taskModel.id, taskModel);
  }
}
