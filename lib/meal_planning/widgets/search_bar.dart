import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:smart_fridge/src/config/math/scaler.dart';
import 'package:smart_fridge/src/config/themes/app_theme.dart';

class AppPageSearchBar extends StatelessWidget {
  final Animation<double>? animation;
  final AnimationController? animationController;
  final Function(String) onSearchChanged;

  const AppPageSearchBar({
    super.key,
    this.animation,
    this.animationController,
    required this.onSearchChanged,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController!,
      builder: (BuildContext context, Widget? child) {
        return FadeTransition(
          opacity: animation!,
          child: Transform(
            transform: Matrix4.translationValues(
                0.0, 30 * (1.0 - animation!.value), 0.0),
            child: Padding(
              padding: const EdgeInsets.only(
                left: 24,
                right: 24,
              ),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppTheme.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: AppTheme.nearlyLighterBlue.withOpacity(0.6),
                      offset: const Offset(2.4, 2.4),
                      blurRadius: 15.0,
                    ),
                  ],
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 5,
                ),
                child: Row(
                  children: [
                    Icon(
                      FontAwesomeIcons.magnifyingGlass,
                      color: AppTheme.grey,
                      size: 20 * Scaler.textScaleFactor(context),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        onChanged: onSearchChanged,
                        style: TextStyle(
                          fontSize: 16 * Scaler.textScaleFactor(context),
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Search for a meal",
                          hintStyle: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
