import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CategoryModel {
  final IconData icon;
  final Color color;
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
    color: Color(0xFFDBECF6),
  ),
  CategoryModel(
    icon: CupertinoIcons.person,
    color: Color(0xFFE7E2F3),
  ),
  CategoryModel(
    icon: CupertinoIcons.person,
    color: Color(0xFFFEF5D3),
  ),
];
