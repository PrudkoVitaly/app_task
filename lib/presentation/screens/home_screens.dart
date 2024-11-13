import 'package:app_task/core/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../../data/data_sourse/data_task.dart';
import '../widgets/calendar.dart';
import '../widgets/task_container_widget.dart';

class HomeScreens extends StatefulWidget {
  const HomeScreens({super.key});

  @override
  State<HomeScreens> createState() => _HomeScreensState();
}

class _HomeScreensState extends State<HomeScreens> {
  @override
  Widget build(BuildContext context) {
    final Box<Task> _taskBox = Hive.box<Task>('tasks');

    TextEditingController titleController = TextEditingController();
    TextEditingController descriptionController = TextEditingController();

    final key = GlobalKey<FormState>();

    @override
    void dispose() {
      titleController.dispose();
      descriptionController.dispose();
      super.dispose();
    }

    void save() {
      final title = titleController.text.trim();
      final description = descriptionController.text.trim();
      if (key.currentState!.validate()) {
        setState(() {
          final data = Task(title: title, description: description);
          _taskBox.add(data);
          Navigator.pop(context);
          titleController.clear();
          descriptionController.clear();
          print(_taskBox.length);
        });
      }
    }

    return Scaffold(
      body: const CustomScrollView(
        slivers: [
          TaskBody(),
        ],
      ),
      floatingActionButton: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        width: double.infinity,
        child: FloatingActionButton(
          onPressed: () {
            showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                  top: Radius.circular(16),
                )),
                builder: (BuildContext context) {
                  return Container(
                    height: 300,
                    child: Column(
                      children: [
                        Form(
                          key: key,
                          child: Column(
                            children: [
                              TextFormField(
                                controller: titleController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Title can't be empty";
                                  }
                                  return null;
                                },
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: "Title",
                                ),
                              ),
                              const SizedBox(height: 20),
                              TextFormField(
                                controller: descriptionController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Notes can't be empty";
                                  }
                                  return null;
                                },
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: "Notes",
                                ),
                              ),
                            ],
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            save();
                          },
                          child: Text("Click"),
                        ),
                      ],
                    ),
                  );
                });
          },
          child: const Text("Add New Task"),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

class TaskBody extends StatelessWidget {
  const TaskBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Stack(
        children: [
          _container(),
          const TaskContainerWidget(),
        ],
      ),
    );
  }

  Widget _container() {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        height: 200,
        color: AppColors.primary,
        child: Container(
          color: AppColors.primary,
          child: Calendar(),
          // child: TimelineCalendar(
          //   calendarType: CalendarType.GREGORIAN,
          //   calendarLanguage: "en",
          //   calendarOptions: CalendarOptions(
          //     bottomSheetBackColor: Colors.red,
          //     viewType: ViewType.DAILY,
          //     headerMonthShadowColor: Colors.black26,
          //     headerMonthBackColor: Colors.transparent,
          //   ),
          //   dayOptions: DayOptions(
          //     compactMode: true,
          //     weekDaySelectedColor: const Color(0xff3AC3E2),
          //     disableDaysBeforeNow: true,
          //     selectedTextColor: Colors.white,
          //   ),
          //   headerOptions: HeaderOptions(
          //     weekDayStringType: WeekDayStringTypes.SHORT,
          //     monthStringType: MonthStringTypes.FULL,
          //     headerTextColor: Colors.white,
          //     navigationColor: Colors.transparent,
          //   ),
          //   onChangeDateTime: (datetime) {
          //     print(datetime.getDate());
          //   },
          // ),
        ),
      ),
    );
  }
}
