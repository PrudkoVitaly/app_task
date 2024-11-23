import 'package:app_task/core/app_colors.dart';
import 'package:app_task/presentation/screens/home_screens.dart';
import 'package:app_task/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

import 'data/model/task_model.dart';
import 'domain/entities/tasks_entities.dart';
import 'presentation/screens/add_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setUpServiceLocator();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.bgColor,
      ),
      home: HomeScreens(),
      // home: AddScreen(),
    );
  }
}
