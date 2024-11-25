import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CategoryModel {
  final IconData icon;
  final int color;
  bool isSelected;

  CategoryModel({
    required this.icon,
    required this.color,
     this.isSelected = false,
  });

}

List<CategoryModel> categories = [
  CategoryModel(
    icon: CupertinoIcons.home,
    color: 0xFFDBECF6,

  ),
  CategoryModel(
    icon: CupertinoIcons.person,
    color: 0xFFE7E2F3,
  ),
  CategoryModel(
    icon: CupertinoIcons.alarm,
    color: 0xFFFEF5D3,
  ),
];
