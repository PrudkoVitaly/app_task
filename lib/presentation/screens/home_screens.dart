import 'package:animate_do/animate_do.dart';
import 'package:app_task/core/app_colors.dart';
import 'package:app_task/presentation/screens/add_screen.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import '../../data/model/task_model.dart';
import '../widgets/task_container_widget.dart';

class HomeScreens extends StatefulWidget {
  const HomeScreens({super.key});

  @override
  State<HomeScreens> createState() => _HomeScreensState();
}

class _HomeScreensState extends State<HomeScreens> {

  final Box<TaskModel> _taskBox = Hive.box<TaskModel>("taskBox");
  final Box<TaskModel> _completedBox = Hive.box<TaskModel>("completedTaskBox");



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            TaskBody(taskBox: _taskBox, completedBox: _completedBox),
          ],
        ),
      ),
      floatingActionButton: ZoomIn(
        duration: const Duration(milliseconds: 2500),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SizedBox(
            width: double.infinity,
            child: FloatingActionButton(
              backgroundColor: AppColors.primary,
              foregroundColor: AppColors.whiteColor,
              child: const Text(
                "Добавить задачу",
                style: TextStyle(fontSize: 18),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddScreen(),
                  ),
                );
              },
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

// Контейнер с задачами
class TaskBody extends StatefulWidget {
  final Box<TaskModel> taskBox;
  final Box<TaskModel> completedBox;

  const TaskBody({super.key, required this.taskBox, required this.completedBox});

  @override
  State<TaskBody> createState() => _TaskBodyState();
}

class _TaskBodyState extends State<TaskBody> {
  DateTime _selectedDate = DateTime.now();

  List<TaskModel> _filteredTaskByDate(Box<TaskModel> box) {
    return box.values
        .where((task) =>
            task.date.year == _selectedDate.year &&
            task.date.month == _selectedDate.month &&
            task.date.day == _selectedDate.day)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Stack(
        children: [
          // Container for the calendar
          _calendar(onDateChange: (date) {
            setState(() {
              _selectedDate = date;
            });
          }),

          // Container for the tasks
          FadeInUpBig(
            child: ValueListenableBuilder(
              valueListenable: widget.taskBox.listenable(),
              builder:
                  (BuildContext context, Box<TaskModel> box, Widget? child) {
                final taskList = _filteredTaskByDate(box);
                return TaskContainerWidget(
                  taskList: taskList,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _calendar({required Function(DateTime)? onDateChange}) {
    return Container(
      height: 230,
      padding: const EdgeInsets.only(top: 20),
      color: AppColors.primary,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          EasyDateTimeLine(
            initialDate: DateTime.now(),
            onDateChange: onDateChange,
            headerProps: const EasyHeaderProps(
                showMonthPicker: false,
                dateFormatter: DateFormatter.fullDateDayAsStrMY(),
                selectedDateStyle: TextStyle(
                  color: AppColors.whiteColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                )),
            dayProps: EasyDayProps(
              dayStructure: DayStructure.dayStrDayNum,
              activeDayStyle: const DayStyle(
                dayNumStyle: TextStyle(
                  color: AppColors.primary,
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                ),
                dayStrStyle: TextStyle(
                  color: AppColors.primary,
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                ),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    color: AppColors.whiteColor),
              ),
              inactiveDayStyle: DayStyle(
                dayStrStyle: const TextStyle(
                  color: AppColors.inActiveCalendarColor,
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                ),
                dayNumStyle: const TextStyle(
                  color: AppColors.inActiveCalendarColor,
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                ),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.transparent),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
