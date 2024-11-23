import 'package:app_task/data/model/task_model.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

class TaskDateSource {

  final Box<TaskModel> _getTask;

  TaskDateSource(this._getTask);

  Future<List<TaskModel>> getTask() async {
    return _getTask.values.toList();
  }

  Future<void> addTask(TaskModel taskModel) async {
    return _getTask.put(taskModel.id, taskModel);
  }
}
