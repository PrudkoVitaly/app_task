import 'package:animate_do/animate_do.dart';
import 'package:app_task/core/app_colors.dart';
import 'package:app_task/data/data_sourse/task_date_source.dart';
import 'package:app_task/domain/entities/tasks_entities.dart';
import 'package:app_task/presentation/screens/add_screen.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import '../../data/model/task_model.dart';
import '../../domain/use_case/get_task_useCase.dart';
import '../../service_locator.dart';
import '../widgets/calendar.dart';
import '../widgets/floating_button_widget.dart';
import '../widgets/task_container_widget.dart';

class HomeScreens extends StatefulWidget {
  const HomeScreens({super.key});

  @override
  State<HomeScreens> createState() => _HomeScreensState();
}

class _HomeScreensState extends State<HomeScreens> {
  OverlayEntry? _overlayEntry;

  // final _taskBox = sl<TaskDateSource>();

  final Box<TaskModel> _taskBox = Hive.box<TaskModel>("taskBox");

  @override
  void initState() {
    super.initState();
    // Показать Overlay после загрузки экрана
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(seconds: 3), () {
        _showOverlay();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          TaskBody(taskBox: _taskBox),
        ],
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

  // Показать Overlay
  void _showOverlay() {
    final overlay = Overlay.of(context);
    _overlayEntry = OverlayEntry(
      builder: (context) =>
          Positioned(
            bottom: 100,
            right: 50,
            child: Material(
              color: Colors.transparent,
              child: _buildSpeechBubble(),
            ),
          ),
    );

    overlay?.insert(_overlayEntry!);

    // Убрать Overlay через 3 секунды
    Future.delayed(const Duration(seconds: 6), () {
      _overlayEntry?.remove();
      _overlayEntry = null;
    });
  }

  // Создаем виджет облака
  Widget _buildSpeechBubble() {
    return BounceInDown(
      duration: const Duration(seconds: 2),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Основной контейнер с текстом
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(15),
            ),
            child: const Text(
              'Добавить новую задачу',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
          // Хвостик облака
          Positioned(
            bottom: -20,
            left: 35,
            child: Transform.rotate(
              angle: 0.5,
              child: CustomPaint(
                size: const Size(30, 30),
                painter: TrianglePainter(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Рисуем треугольник для хвостика
class TrianglePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.fill;

    final path = Path();
    path.moveTo(0, 0);
    path.lineTo(size.width / 2, size.height);
    path.lineTo(size.width, 0);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Контейнер с задачами
class TaskBody extends StatelessWidget {
  final Box<TaskModel> taskBox;

  const TaskBody({super.key, required this.taskBox});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Stack(
        children: [
          // Container for the calendar
          _calendar(),

          // Container for the tasks
          FadeInUpBig(
            child: ValueListenableBuilder(
              valueListenable: taskBox.listenable(),
              builder: (BuildContext context, Box<TaskModel> box,
                  Widget? child) {
                final taskList = box.values.toList();
                return TaskContainerWidget(taskList: taskList,);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _calendar() {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        height: 200,
        color: AppColors.primary,
        child: Container(
          color: AppColors.primary,
          child: const Calendar(),
        ),
      ),
    );
  }
}
