import 'package:app_task/core/app_colors.dart';
import 'package:flutter/material.dart';

import '../widgets/app_bar_widget.dart';
import '../widgets/task_container_widget.dart';

class HomeScreens extends StatelessWidget {
  const HomeScreens({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: CustomScrollView(
        slivers: [
          TaskBody(),
        ],
      ),
    );
  }
}

class TaskBody extends StatelessWidget {
  const TaskBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
        child: Stack(
      children: [
        _container(),
        const TaskContainerWidget(),
      ],
    ));
  }

  Widget _container() {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        height: 200,
        color: AppColors.primary,
      ),
    );
  }


}
