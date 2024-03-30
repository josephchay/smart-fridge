import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smart_fridge/src/config/themes/app_theme.dart';
import 'package:smart_fridge/src/models/drawer_icon.dart';

class AppDrawerPlate extends StatelessWidget {
  const AppDrawerPlate({
    super.key,
    required this.isLightMode,
    required this.tab,
    required this.press,
    // required this.iconOnInit,
    required this.isActive,
  });

  final bool isLightMode;
  final AppDrawerIcon tab;
  final VoidCallback press;
  // final ValueChanged<rive.Artboard> iconOnInit;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 24),
          // child: Divider(
          //   color: Colors.white24,
          //   height: 1,
          // ),
        ),
        Stack(
          children: [
            AnimatedPositioned(
              duration: const Duration(milliseconds: 300),
              curve: Curves.fastOutSlowIn,
              height: 56,
              width: isActive ? 288 : 0,
              child: Container(
                decoration: BoxDecoration(
                  color: AppTheme.nearlyWhite.withOpacity(isActive ? 0.3 : 0.0),
                  borderRadius: const BorderRadius.all(Radius.circular(14)),
                  border: isActive
                      ? Border.all(
                          color: AppTheme.nearlyTiger.withOpacity(0.1),
                          width: 1.0,
                        )
                      : null,
                ),
                child: Opacity(
                  opacity: 0.0, // Set to 0 to make the shadow-only button
                  child: Container(),
                ),
              ),
            ),
            ListTile(
              onTap: press,
              leading: SizedBox(
                height: 24,
                width: 24,
                child: SvgPicture.asset(
                  tab.src,
                  color: AppTheme.nearlyWhite,
                ),
              ),
              title: Text(
                tab.title,
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
