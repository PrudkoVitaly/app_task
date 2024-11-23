import 'package:app_task/data/model/task_model.dart';
import 'package:flutter/material.dart';

import '../../core/app_colors.dart';
import 'completed_container_widget.dart';

class TaskContainerWidget extends StatefulWidget {
  final double top;
  final List<TaskModel> taskList;


  const TaskContainerWidget({super.key, this.top = 160, required this.taskList});

  @override
  State<TaskContainerWidget> createState() => _TaskContainerWidgetState();
}

class _TaskContainerWidgetState extends State<TaskContainerWidget> {
  bool defaultValue = false;
  double defaultHeight = 700;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(
              top: widget.top,
            ),
            height: 85 * double.parse(widget.taskList.length.toString()),
            decoration: BoxDecoration(
              color: AppColors.whiteColor,
              borderRadius: BorderRadius.circular(16),
            ),
            child: _listItems(defaultValue, (value) {
              setState(() {
                defaultValue = value!;
              });
            }, widget.taskList),
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
          CompletedContainerWidget(),
        ],
      ),
    );
  }
}

Widget _listItems(bool value, Function(bool?)? onChanged, List<TaskModel> taskList) {
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
              leading: const CircleAvatar(
                backgroundColor: AppColors.primary,
              ),
              title: Text(taskList[index].title),
              subtitle:  Text(taskList[index].notes),
              trailing: Checkbox(
                value: value,
                onChanged: onChanged,
              ),
            ),
          ],
        ),
      );
    },
  );
}
