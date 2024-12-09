import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';

import '../../core/app_colors.dart';

Widget calendar({required Function(DateTime)? onDateChange}) {
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