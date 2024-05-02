import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:smart_fridge/src/config/themes/app_theme.dart';

class DrawerToggleButton extends StatelessWidget {
  const DrawerToggleButton({
    super.key,
    required this.press,
    required this.iconOnInit,
  });

  final VoidCallback press;
  final ValueChanged<Artboard> iconOnInit;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: press,
        child: Container(
          margin: const EdgeInsets.only(left: 20),
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: AppTheme.white,
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            boxShadow: [
              BoxShadow(
                color: AppTheme.lighterGrey.withOpacity(0.1),
                offset: const Offset(0.0, 3.0),
                blurRadius: 8,
                spreadRadius: 8,
              )
            ],
          ),
          child: RiveAnimation.asset(
            "assets/images/icons/rive/menu_button.riv",
            onInit: iconOnInit,
          ),
        ),
      ),
    );
  }
}
