import 'package:rive/rive.dart';

class AppDrawerIcon {
  final String title, src;
  late SMIBool? input;

  AppDrawerIcon({
    required this.title,
    required this.src,
    this.input,
  });

  set setInput(SMIBool status) {
    input = status;
  }
}

List<AppDrawerIcon> drawerTopTabIcons = [
  AppDrawerIcon(
    title: "Grocery",
    src: "assets/images/icons/drawer/file-lines.svg",
  ),
  AppDrawerIcon(
    title: "Search",
    src: "assets/images/icons/drawer/magnifying-glass-solid.svg",
  ),
  AppDrawerIcon(
    title: "Notifications",
    src: "assets/images/icons/drawer/bell-regular.svg",
  ),
];

List<AppDrawerIcon> drawerBottomTabIcons = [
  AppDrawerIcon(
    title: "Settings",
    src: "assets/images/icons/drawer/gear.svg",
  ),
  AppDrawerIcon(
    title: "Logout",
    src: "assets/images/icons/drawer/arrow-right-from-bracket-solid.svg",
  ),
];
