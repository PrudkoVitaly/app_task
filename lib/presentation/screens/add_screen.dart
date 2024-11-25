import 'package:animate_do/animate_do.dart';
import 'package:app_task/domain/entities/tasks_entities.dart';
import 'package:app_task/domain/use_case/add_task_useCase.dart';
import 'package:app_task/presentation/screens/home_screens.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../../core/app_colors.dart';
import '../../core/utils.dart';
import '../../data/model/categoty_model.dart';
import '../../data/model/task_model.dart';
import '../../service_locator.dart';
import '../widgets/app_bar_widget.dart';
import '../widgets/floating_button_widget.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({super.key});

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController notesController = TextEditingController();
  final key = GlobalKey<FormState>();

  @override
  void dispose() {
    titleController.dispose();
    notesController.dispose();
    super.dispose();
  }

  // Selected Category
  int? selectedCategoryIndex;

  // Selected Date
  DateTime selectedDate = DateTime.now();

  Future<void> _showCalendar() async {
    DateTime? pickDate = await showDatePicker(
      context: context,
      firstDate: DateTime(2015, 1, 1),
      lastDate: DateTime(2030, 1, 1),
    );
    if (pickDate != null && pickDate != selectedDate) {
      setState(() {
        selectedDate = pickDate;
      });
    }
  }

  // Selected Time
  TimeOfDay? selectedTime;

  Future<void> _showTimePicker() async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedTime != null && pickedTime != selectedTime) {
      setState(() {
        selectedTime = pickedTime;
      });
    }
  }

  final addTaskUseCase = sl<AddTaskUseCase>();



  void save() async {
    final title = titleController.text;
    final notes = notesController.text;
    if (key.currentState!.validate() && selectedCategoryIndex != null && selectedTime != null ) {
      final task = TasksEntities(
        title: title,
        color: categories[selectedCategoryIndex!].color,
        icon: categoryIcons.keys.toList()[selectedCategoryIndex!],
        date: selectedDate,
        hour: selectedTime!.hour,
        minute: selectedTime!.minute,
        notes: notes,
        id: DateTime.now().toString(),
      );

      await addTaskUseCase.call(task);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(context: context),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Form(
          key: key,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Text Widget
              BounceInDown(
                  duration: const Duration(milliseconds: 1500),
                  child: _textWidget(text: "Task Title")),
              const SizedBox(height: 10),

              // TextFormField
              SlideInLeft(
                duration: const Duration(milliseconds: 1500),
                child: _textFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter task title";
                    }
                    return null;
                  },
                  hintText: "Task Title",
                  controller: titleController,
                ),
              ),

              // Category Widget
              BounceInDown(
                duration: const Duration(milliseconds: 1500),
                child: _categoryWidget(),
              ),
              const SizedBox(height: 20),

              // Date and Time Widget
              buttons(),
              const SizedBox(height: 20),

              // Text Widget
              BounceInDown(
                duration: const Duration(milliseconds: 1500),
                child: _textWidget(text: "Notes"),
              ),
              const SizedBox(height: 10),

              // TextFormField
              SlideInLeft(
                duration: const Duration(milliseconds: 1500),
                child: _textFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Notes can't be empty";
                    }
                    return null;
                  },
                  hintText: "Notes",
                  maxLines: 5,
                  controller: notesController,
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: BounceInDown(
        duration: const Duration(milliseconds: 2000),
        child: FloatingButtonWidget(
          title: "Сохранить",
          onPressed: () {
            save();
          },
        ),
      ),
    );
  }

  Widget _categoryWidget() {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Row(
        children: [
          _textWidget(text: "Category"),
          const SizedBox(width: 30),
          Expanded(
            child: SizedBox(
              height: 80,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final isSelected = selectedCategoryIndex == index;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                         selectedCategoryIndex = index;
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: CircleAvatar(
                        backgroundColor:
                            isSelected ? AppColors.primary : AppColors.whiteColor,
                        radius: 27,
                        child: CircleAvatar(
                          backgroundColor: Color(categories[index].color),
                          radius: 25,
                          child: Icon(
                            categories[index].icon,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buttons() {
    return Row(
      children: [
        _showButton(
            text: selectedDate == null
                ? "Date"
                : "${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}",
            icon: Icons.calendar_month,
            onTap: () {
              _showCalendar();
            }),
        const SizedBox(width: 10),
        _showButton(
            text: selectedTime == null
                ? "Time"
                : "${selectedTime!.hour}:${selectedTime!.minute}",
            icon: Icons.access_time,
            onTap: () {
              _showTimePicker();
            }),
      ],
    );
  }
}

Widget _showButton(
    {required String text, required IconData icon, Function()? onTap}) {
  return Expanded(
    child: GestureDetector(
      onTap: onTap,
      child: Container(
        height: 50,
        width: 150,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(text),
            Icon(icon),
          ],
        ),
      ),
    ),
  );
}

Widget _textFormField({
  required String hintText,
  int maxLines = 1,
  required TextEditingController controller,
  String? Function(String?)? validator,
}) {
  return TextFormField(
    controller: controller,
    validator: validator,
    maxLines: maxLines,
    decoration: InputDecoration(
      filled: true,
      fillColor: AppColors.whiteColor,
      hintText: hintText,
      hintStyle: const TextStyle(
        color: AppColors.greyColor,
      ),
      border: _border(),
      focusedBorder: _border(color: AppColors.primary),
      enabledBorder: _border(),
    ),
  );
}

InputBorder _border({Color color = AppColors.borderColor}) {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(6),
    borderSide: BorderSide(
      color: color,
      width: 2,
    ),
  );
}

Widget _textWidget({required String text}) {
  return Text(
    text,
    style: const TextStyle(
        fontSize: 14, fontWeight: FontWeight.w800, color: AppColors.blackColor),
  );
}
