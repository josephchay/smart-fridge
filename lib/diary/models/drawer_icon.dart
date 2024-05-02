import 'dart:ui';

import 'package:rive/rive.dart';
import 'package:smart_fridge/data/repositories/authentication/authentication_repository.dart';

class AppDrawerTab {
  final String title, src;
  late SMIBool? input;
  final VoidCallback action; // Action to be performed when the icon is clicked

  AppDrawerTab({
    required this.title,
    required this.src,
    this.input,
    required this.action,
  });

  set setInput(SMIBool status) {
    input = status;
  }
}

List<AppDrawerTab> drawerTopTabs = [
  AppDrawerTab(
    title: "Grocery",
    src: "assets/images/icons/drawer/file-lines.svg",
    action: () {},
  ),
  AppDrawerTab(
    title: "Search",
    src: "assets/images/icons/drawer/magnifying-glass-solid.svg",
    action: () {},
  ),
  AppDrawerTab(
    title: "Notifications",
    src: "assets/images/icons/drawer/bell-regular.svg",
    action: () {},
  ),
];

List<AppDrawerTab> drawerBottomTabs = [
  // AppDrawerTab(
  //   title: "Settings",
  //   src: "assets/images/icons/drawer/gear.svg",
  //   action: () {},
  // ),
  AppDrawerTab(
    title: "Logout",
    src: "assets/images/icons/drawer/arrow-right-from-bracket-solid.svg",
    action: () => AuthenticationRepository.instance.logout(),
  ),
];
