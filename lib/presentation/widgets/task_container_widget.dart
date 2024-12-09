import 'package:app_task/data/model/task_model.dart';
import 'package:app_task/domain/use_case/completed_task_use_case.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../../core/app_colors.dart';
import '../../core/utils.dart';
import '../../domain/entities/tasks_entities.dart';
import '../../domain/use_case/get_task_useCase.dart';
import '../../service_locator.dart';
import 'completed_container_widget.dart';

class TaskContainerWidget extends StatefulWidget {
  final double top;
  final List<TaskModel> taskList;

  const TaskContainerWidget(
      {super.key, this.top = 160, required this.taskList});

  @override
  State<TaskContainerWidget> createState() => _TaskContainerWidgetState();
}

class _TaskContainerWidgetState extends State<TaskContainerWidget> {
  bool defaultValue = false;
  double defaultHeight = 700;
  final completedTaskUseCase = sl<CompletedTaskUseCase>();

  Future<void> completedTask(String id, TasksEntities tasksEntities) async {
    await completedTaskUseCase.call(id, tasksEntities);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          widget.taskList.isEmpty
              ? Container(
                  margin: EdgeInsets.only(top: widget.top),
                  alignment: Alignment.center,
                  height: 200,
                  width: double.infinity,
                  color: Colors.white,
                  child: const Text(
                    "No Tasks for today",
                  ),
                )
              : Container(
                  margin: EdgeInsets.only(
                    top: widget.top,
                  ),
                  height: 85 * double.parse(widget.taskList.length.toString()),
                  decoration: BoxDecoration(
                    color: AppColors.whiteColor,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: _listItems(
                    taskList: widget.taskList,

                  ),
                ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 24),
            child: Text(
              "Completed",
              style: TextStyle(
                color: AppColors.blackColor,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const CompletedContainerWidget(),
        ],
      ),
    );
  }
  Widget _listItems(
      {required List<TaskModel> taskList}) {
    return ListView.separated(
      itemCount: taskList.length,
      separatorBuilder: (context, index) {
        return const Divider();
      },
      itemBuilder: (context, index) {
        return SingleChildScrollView(
          child: Column(
            children: [
              ListTile(
                leading: CircleAvatar(
                  radius: 40,
                  backgroundColor: Color(taskList[index].color),
                  child: Icon(
                    categoryIcons[taskList[index].icon],
                  ),
                ),
                title: Text(taskList[index].title),
                subtitle: Text(
                    "${taskList[index].notes} ${taskList[index].hour} : ${taskList[index].minute}"),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: (){
                        completedTask(taskList[index].id, taskList[index] as TasksEntities);
                      },
                      icon: const Icon(
                        Icons.check_box_outline_blank,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.delete,
                        color: AppColors.blackColor,
                      ),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}


