import 'package:app_task/core/app_colors.dart';
import 'package:flutter/material.dart';

import '../../core/app_assets/app_icons.dart';

PreferredSizeWidget appBarWidget({
  required BuildContext context,
  double height = 70,
}) {
  return PreferredSize(
    preferredSize: Size.fromHeight(height),
    child: AppBar(
      backgroundColor: AppColors.primary,
      leading: _backButton(context),
      centerTitle: true,
      title: _titleText(),
    ),
  );
}

Widget _backButton(BuildContext context) {
  return GestureDetector(
    onTap: () {
      Navigator.pop(context);
    },
    child: Padding(
      padding: const EdgeInsets.only(left: 20),
      child: CircleAvatar(
        backgroundColor: AppColors.whiteColor,
        child: Image.asset(
          AppIcons.cancelIcon,
        ),
      ),
    ),
  );
}

Widget _titleText() {
  return const Text(
    "Add New Task",
    style: TextStyle(
      color: AppColors.whiteColor,
      fontSize: 16,
      fontWeight: FontWeight.w600,
    ),
  );
}
