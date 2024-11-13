import 'package:app_task/core/app_colors.dart';
import 'package:app_task/presentation/screens/home_screens.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

import 'data/data_sourse/data_task.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox<Task>('tasks');



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
          // floatingActionButtonTheme: FloatingActionButtonThemeData(
          //   backgroundColor: AppColors.primary,
          //   shape: RoundedRectangleBorder(
          //     borderRadius: BorderRadius.circular(50),
          //   ),
          //   foregroundColor: AppColors.whiteColor,
          // )
          // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          // useMaterial3: true,
          ),
      home: HomeScreens(),
    );
  }
}
