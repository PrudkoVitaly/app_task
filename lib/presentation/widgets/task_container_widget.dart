import 'package:flutter/material.dart';

import '../../core/app_colors.dart';
import 'completed_container_widget.dart';

class TaskContainerWidget extends StatefulWidget {
  final double top;

  const TaskContainerWidget({super.key, this.top = 160});

  @override
  State<TaskContainerWidget> createState() => _TaskContainerWidgetState();
}

class _TaskContainerWidgetState extends State<TaskContainerWidget> {
  bool defaultValue = false;
  double defaultHeight = 700;
  int defaultCount = 20;

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
            height: 272,
            decoration: BoxDecoration(
              color: AppColors.whiteColor,
              borderRadius: BorderRadius.circular(16),
            ),
            child: _listItems(defaultValue, (value) {
              setState(() {
                defaultValue = value!;
              });
            }, defaultCount),
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

Widget _listItems(bool value, Function(bool?)? onChanged, int count) {
  return ListView.separated(
    itemCount: count,
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
              title: Text('Task ${index + 1}'),
              subtitle: const Text('Description'),
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
