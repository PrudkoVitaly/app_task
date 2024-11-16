class TasksEntities {
  final String title;
  final int color;
  final String icon;
  final DateTime date;
  final int hour;
  final int minute;
  final String notes;
  bool isDone;

  TasksEntities({
    required this.title,
    required this.color,
    required this.icon,
    required this.date,
    required this.hour,
    required this.minute,
    required this.notes,
    this.isDone = false,
  });
}


