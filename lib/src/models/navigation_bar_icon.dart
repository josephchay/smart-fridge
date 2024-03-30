import 'package:flutter/material.dart';

class AppNavigationBarIcon {
  String icon;
  String selectedIcon;
  bool isSelected;
  int index;
  AnimationController? animationController;

  AppNavigationBarIcon({
    this.icon = '',
    this.index = 0,
    this.selectedIcon = '',
    this.isSelected = false,
    this.animationController,
  });

  static Map<String, AppNavigationBarIcon> navigationBarIcons = {
    'diary': AppNavigationBarIcon(
      icon: 'assets/images/clipboard-list.svg',
      selectedIcon: 'assets/images/clipboard-list-solid.svg',
      index: 0,
      isSelected: true,
      animationController: null,
    ),
    'grocery': AppNavigationBarIcon(
      icon: 'assets/images/bag-shopping.svg',
      selectedIcon: 'assets/images/bag-shopping-solid.svg',
      index: 1,
      isSelected: false,
      animationController: null,
    ),
    'notification': AppNavigationBarIcon(
      icon: 'assets/images/bell.svg',
      selectedIcon: 'assets/images/bell-solid.svg',
      index: 2,
      isSelected: false,
      animationController: null,
    ),
    'meal': AppNavigationBarIcon(
      icon: 'assets/images/utensils.svg',
      selectedIcon: 'assets/images/utensils-solid.svg',
      index: 3,
      isSelected: false,
      animationController: null,
    ),
  };
}
