import 'package:app_task/core/app_colors.dart';
import 'package:flutter/material.dart';

import '../../core/app_assets/app_icons.dart';

PreferredSizeWidget appBarWidget({
  required BuildContext context,
  double height = 70,
  bool isVisible = true,
}) {
  return PreferredSize(
    preferredSize: Size.fromHeight(height),
    child: AppBar(
      backgroundColor: AppColors.primary,
      leading: _backButton(context, isVisible),
      centerTitle: true,
      title: _titleText(isVisible),
    ),
  );
}

Widget _backButton(BuildContext context, bool isVisible) {
  return Visibility(
    visible: isVisible,
    child: CircleAvatar(
      backgroundColor: AppColors.whiteColor,
      child: Image.asset(
        AppIcons.cancelIcon,
      ),
    ),
  );
}

Widget _titleText(bool isVisible) {
  return Visibility(
    visible: isVisible,
    child: Text(
      "Add New Task",
      style: TextStyle(
        color: AppColors.whiteColor,
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
    ),
  );
}
