import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:flutter/material.dart';

class Calendar extends StatefulWidget {
  const Calendar({super.key});

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  late DateTime _selectedDate;
  late List<DateTime> _eventDates;

  @override
  void initState() {
    super.initState();
    _resetSelectedDate();
  }

  void _resetSelectedDate() {
    _selectedDate = DateTime.now().add(const Duration(days: 2));
    _eventDates = [
      DateTime.now().add(const Duration(days: 2)),
      DateTime.now().add(const Duration(days: 3)),
      DateTime.now().add(const Duration(days: 4)),
      DateTime.now().subtract(const Duration(days: 4)),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return CalendarTimeline(
      showYears: false,
      initialDate: DateTime.now(),
      firstDate: DateTime(2024, 1, 1),
      lastDate: DateTime.now().add(const Duration(days: 365 * 4)),
      eventDates: _eventDates,
      onDateSelected: (date) => setState(() => _selectedDate = date),
      leftMargin: 12,
      monthColor: Colors.white70,
      dayColor: Colors.teal[200],
      // dayNameColor: const Color(0xFF333A47),
      activeDayColor: Colors.white,
      activeBackgroundDayColor: Colors.redAccent[100],
      dotColor: Colors.white,
      selectableDayPredicate: (date) => date.day != 23,
      locale: 'ru',
    );
  }
}
