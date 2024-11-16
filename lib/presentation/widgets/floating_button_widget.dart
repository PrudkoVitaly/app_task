import 'package:app_task/presentation/screens/home_screens.dart';
import 'package:flutter/material.dart';

import '../../core/app_colors.dart';

class FloatingButtonWidget extends StatelessWidget {
  final String title;
  final void Function()? onPressed;

   FloatingButtonWidget({super.key, required this.title, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      width: double.infinity,
      child: FloatingActionButton(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.whiteColor,
        onPressed: onPressed,
        child:  Text(
          title,
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
