import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FoodCategory {
  final String name;
  final String iconPath;
  final Color color;
  final String imagePath;
  final List<FoodCategory> subCategories;

  FoodCategory({
    required this.name,
    required this.iconPath,
    required this.color,
    required this.imagePath,
    required this.subCategories,
  });

  static List<FoodCategory> categories = [
    FoodCategory(
      color: const Color(0xFFFA7D82),
      name: "Vegetables",
      iconPath: 'assets/images/icons/grocery/vegetables.svg',
      imagePath: 'assets/images/icons/grocery/vegetables.png',
      subCategories: [],
    ),
    FoodCategory(
      color: const Color(0xFFFA7D82),
      name: "Meat",
      iconPath: 'assets/images/icons/grocery/meat.svg',
      imagePath: 'assets/images/icons/grocery/meat.png',
      subCategories: [],
    ),
  ];
}
