import 'package:app_task/core/app_navigation.dart';
import 'package:app_task/presentation/screens/add_screen.dart';
import 'package:app_task/presentation/screens/body/task_body.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../../data/model/task_model.dart';
import '../widgets/calendar.dart';
import '../widgets/floating_button_widget.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late DateTime selectedDate;
  final Box<TaskModel> taskBox = Hive.box<TaskModel>("taskBox");
  final Box<TaskModel> completedBox = Hive.box<TaskModel>("completedTaskBox");


  @override
  void initState() {
    selectedDate = DateTime.now();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Stack(
                children: [
                  calendar(onDateChange: (date) {
                    setState(() {
                      selectedDate = date;
                    });
                  }),
                  TaskBody(
                    taskBox: taskBox,
                    selectedDate: selectedDate,
                    top: 180,
                  ),
                  // TaskBody(
                  //   taskBox: completedBox,
                  //   selectedDate: selectedDate,
                  //   top: top(),
                  //   isDone: true,
                  // ),


                ],
              ),
            ),
            SliverToBoxAdapter(
              child:  TaskBody(
                taskBox: completedBox,
                selectedDate: selectedDate,
                top: 20,
                isDone: true,
              ),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(height: 100),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingButtonWidget(
        title: "Add New Task",
        onPressed: () {
          Navigator.push(
                  context, MaterialPageRoute(builder: (_) => const AddScreen()))
              .then((_) {
            setState(() {});
          });
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
