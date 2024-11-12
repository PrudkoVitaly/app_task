import 'package:flutter/material.dart';

import '../../core/app_colors.dart';

class TaskContainerWidget extends StatefulWidget {
  final double top;

  const TaskContainerWidget({super.key, this.top = 160});

  @override
  State<TaskContainerWidget> createState() => _TaskContainerWidgetState();
}

class _TaskContainerWidgetState extends State<TaskContainerWidget> {
  bool defaultValue = false;
  double defaultHeight = 105;
  int defaultCount = 1;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: widget.top, right: 20, left: 20),
      height: defaultHeight * defaultCount,
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: _listItems(defaultValue, (value) {
        setState(() {
          defaultValue = value!;
        });
      }, defaultCount),
    );
  }
}

Widget _listItems(bool value, Function(bool?)? onChanged, int count) {
  return ListView.builder(
    itemCount: count,
    itemBuilder: (context, index) {
      return Column(
        children: [
          ListTile(
            leading: CircleAvatar(
              backgroundColor: AppColors.primary,
            ),
            title: Text('Task ${index + 1}'),
            subtitle: Text('Description'),
            trailing: Checkbox(
              value: value,
              onChanged: onChanged,
            ),
          ),
          Divider(),
        ],
      );
    },
  );
}
