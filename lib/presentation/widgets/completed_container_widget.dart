import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../../core/app_colors.dart';

class CompletedContainerWidget extends StatefulWidget {
  const CompletedContainerWidget({super.key});

  @override
  State<CompletedContainerWidget> createState() =>
      _CompletedContainerWidgetState();
}

class _CompletedContainerWidgetState extends State<CompletedContainerWidget> {
  bool isChecked = false;



  void addTask() {
    showBottomSheet(
      context: context,
      builder: (context) => Container(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 260,
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: ListView.separated(
        itemCount: 2,
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
                  title: Text('Task'),
                  subtitle: const Text('Description'),
                  trailing: Checkbox(
                    value: isChecked,
                    onChanged: (value) {
                      setState(() {
                        isChecked = value!;
                      });
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
