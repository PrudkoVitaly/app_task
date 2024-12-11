import 'package:app_task/domain/use_case/completed_task_deleted_useCase.dart';
import 'package:app_task/domain/use_case/delete_task_useCase.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

import '../../../core/app_colors.dart';
import '../../../core/utils.dart';
import '../../../data/model/task_model.dart';
import '../../../domain/entities/tasks_entities.dart';
import '../../../domain/use_case/completed_task_use_case.dart';
import '../../../domain/use_case/return_task_useCase.dart';
import '../../../service_locator.dart';

class TaskBody extends StatefulWidget {
  final Box<TaskModel> taskBox;
  final DateTime selectedDate;
  final double top;
  final bool isDone;

  TaskBody({
    super.key,
    required this.taskBox,
    required this.selectedDate,
    required this.top,
    this.isDone = false,
  });

  @override
  State<TaskBody> createState() => _TaskBodyState();
}

class _TaskBodyState extends State<TaskBody> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: widget.taskBox.listenable(),
      builder: (BuildContext context, Box<TaskModel> box, Widget? child) {
        final taskList = _filteredTaskByDate(box);
        return Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
          ),
          child: Column(
            children: [
              taskList.isEmpty
                  ? _emptyContainer()
                  : _taskContainer(
                      taskList: taskList,
                      isDone: widget.isDone,
                    ),
            ],
          ),
        );
      },
    );
  }

  final completedTaskUseCase = sl<CompletedTaskUseCase>();
  final deleteTaskUseCase = sl<DeleteTaskUseCase>();
  final completedTaskDeletedUseCase = sl<CompletedTaskDeletedUseCase>();
  final returnTaskUseCase = sl<ReturnTaskUseCase>();

  void completedTask(String id, TaskModel taskModel) async {
    final taskEntities = TasksEntities(
      id: taskModel.id,
      title: taskModel.title,
      color: taskModel.color,
      icon: taskModel.icon,
      date: taskModel.date,
      hour: taskModel.hour,
      minute: taskModel.minute,
      notes: taskModel.notes,
    );
    await completedTaskUseCase.call(id, taskEntities);
    setState(() {});
  }

  void deleteTask(String id) async {
    await deleteTaskUseCase.call(id);
    setState(() {});
  }

  void completedTaskDeleted(String id) async {
    await completedTaskDeletedUseCase.call(id);
    setState(() {});
  }

  void returnTask(String id, TaskModel taskModel) async {
    final taskEntities = TasksEntities(
      id: taskModel.id,
      title: taskModel.title,
      color: taskModel.color,
      icon: taskModel.icon,
      date: taskModel.date,
      hour: taskModel.hour,
      minute: taskModel.minute,
      notes: taskModel.notes,
    );
    await returnTaskUseCase.call(id, taskEntities);
    setState(() {});
  }

  List<TaskModel> _filteredTaskByDate(Box<TaskModel> box) {
    return box.values
        .where((task) =>
            task.date.year == widget.selectedDate.year &&
            task.date.month == widget.selectedDate.month &&
            task.date.day == widget.selectedDate.day)
        .toList();
  }

  Widget _emptyContainer() {
    return Container(
      margin: EdgeInsets.only(top: widget.top),
      alignment: Alignment.center,
      height: 200,
      width: double.infinity,
      color: Colors.white,
      child: const Text(
        "No Tasks for today",
      ),
    );
  }

  Widget _taskContainer({
    required List<TaskModel> taskList,
    required bool isDone,
  }) {
    return Container(
      margin: EdgeInsets.only(
        top: widget.top,
      ),
      height: 85 * double.parse(taskList.length.toString()),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        itemCount: taskList.length,
        separatorBuilder: (context, index) {
          return const Divider();
        },
        itemBuilder: (context, index) {
          return Dismissible(
            key: Key(taskList[index].id),
            background: Container(
              color: Colors.red,
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: const Icon(
                Icons.delete,
                color: Colors.white,
              ),
            ),
            onDismissed: isDone
                ? (direction) {
                    completedTaskDeleted(taskList[index].id);
                  }
                : (direction) {
                    deleteTask(taskList[index].id);
                  },
            child: Container(
              alignment:  Alignment.centerLeft,
              height: 85,
              decoration:  BoxDecoration(
                color: AppColors.whiteColor,
                borderRadius: BorderRadius.circular(16),
              ),
              child: ListTile(

                leading: CircleAvatar(
                  radius: 40,
                  backgroundColor: Color(taskList[index].color),
                  child: Icon(
                    categoryIcons[taskList[index].icon],
                  ),
                ),
                title: Text(
                  taskList[index].title,
                  style: TextStyle(
                    decoration:
                        isDone ? TextDecoration.lineThrough : TextDecoration.none,
                  ),
                ),
                subtitle: Text(
                  "${taskList[index].notes} ${taskList[index].hour} : ${taskList[index].minute}",
                  style: TextStyle(
                    decoration:
                        isDone ? TextDecoration.lineThrough : TextDecoration.none,
                  ),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: isDone
                          ? () {
                        returnTask(taskList[index].id, taskList[index]);
                      }
                          : () {
                              completedTask(taskList[index].id, taskList[index]);
                            },
                      icon: isDone
                          ? const Icon(
                              Icons.check_box,
                              color: AppColors.primary,
                            )
                          : const Icon(
                              Icons.check_box_outline_blank,
                            ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
