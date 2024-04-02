import 'package:flutter/material.dart';
import 'package:smart_fridge/core/util/color.dart';
import 'package:smart_fridge/meal_planning/models/category.dart';
import 'package:smart_fridge/src/config/math/scaler.dart';
import 'package:smart_fridge/src/config/themes/app_theme.dart';

class AppMealPlannerFoodCategories extends StatelessWidget {
  final String current;
  final Animation<double>? animation;
  final AnimationController? animationController;

  const AppMealPlannerFoodCategories({
    super.key,
    required this.current,
    this.animation,
    this.animationController,
  });

  @override
  Widget build(BuildContext context) {
    double radius = 12;

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
              child: ClipRRect(
                borderRadius: BorderRadius.circular(0),
                child: Container(
                  decoration: BoxDecoration(
                    // This decoration is applied to the container wrapping the scroll view
                    borderRadius:
                        BorderRadius.circular(0), // Match the ClipRRect radius
                  ),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 10,
                      ),
                      child: Row(
                        children: List.generate(
                          categoryList.length,
                          (index) {
                            final category = categoryList[index];
                            return Container(
                              decoration: BoxDecoration(
                                color: current == category.title
                                    ? AppTheme.nearlyOrange
                                    : AppTheme.white,
                                gradient: current == category.title
                                    ? LinearGradient(
                                        colors: [
                                          AppTheme.nearlyOrange,
                                          HexColor('#FF9159'),
                                        ],
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                      )
                                    : null,
                                borderRadius: BorderRadius.circular(radius),
                                boxShadow: current == category.title
                                    ? <BoxShadow>[
                                        // Start with a darker, less blurred shadow
                                        BoxShadow(
                                          color: AppTheme.nearlyOrange
                                              .withOpacity(0.5),
                                          offset: const Offset(2.4, 2.4),
                                          blurRadius: 5.0,
                                        ),
                                        // Then add progressively lighter, more blurred shadows
                                        BoxShadow(
                                          color: HexColor('#FF6759')
                                              .withOpacity(0.5),
                                          offset: const Offset(2.4, 2.4),
                                          blurRadius: 5.0,
                                        ),
                                        BoxShadow(
                                          color: AppTheme.nearlyOrange
                                              .withOpacity(
                                                  0.3), // Lighter color
                                          offset: const Offset(2.4, 2.4),
                                          blurRadius: 5.0,
                                        ),
                                        // Add more BoxShadows here if needed to enhance the gradient effect
                                      ]
                                    : <BoxShadow>[
                                        BoxShadow(
                                          color: AppTheme.nearlyLighterBlue
                                              .withOpacity(0.6),
                                          offset: const Offset(2.4, 2.4),
                                          blurRadius: 15.0,
                                        ),
                                      ],
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 10,
                              ),
                              margin: const EdgeInsets.symmetric(
                                horizontal: 8,
                              ),
                              child: Text(
                                category.title,
                                style: TextStyle(
                                  color: current == category.title
                                      ? AppTheme.white
                                      : AppTheme.grey,
                                ),
                                textScaleFactor:
                                    Scaler.textScaleFactor(context),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
