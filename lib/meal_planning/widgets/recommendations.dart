import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:smart_fridge/meal_planning/models/meal.dart';
import 'package:smart_fridge/meal_planning/screens/meal_screen.dart';
import 'package:smart_fridge/meal_planning/widgets/meal-card.dart';
import 'package:smart_fridge/config/math/scaler.dart';
import 'package:smart_fridge/config/themes/app_theme.dart';
import 'package:smart_fridge/utils/formatters/datetime.dart';

class AppMealPlannerRecommendations extends StatefulWidget {
  final Animation<double>? animation;
  final AnimationController? animationController;
  final List<Meal> meals;

  const AppMealPlannerRecommendations({
    super.key,
    this.animation,
    this.animationController,
    required this.meals,
  });

  @override
  _AppMealPlannerRecommendationsState createState() =>
      _AppMealPlannerRecommendationsState();
}

class _AppMealPlannerRecommendationsState
    extends State<AppMealPlannerRecommendations> with TickerProviderStateMixin {
  List<Meal> displayedMeals = [];

  AnimationController? horizontalAnimationController;

  @override
  void initState() {
    super.initState();
    horizontalAnimationController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    _prepareList();
  }

  @override
  void didUpdateWidget(covariant AppMealPlannerRecommendations oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.meals != widget.meals) {
      _prepareList(); // Update the list if the incoming meals change
    }
  }

  void _prepareList() {
    displayedMeals = widget.meals;
    if (displayedMeals.length > 20) {
      displayedMeals = displayedMeals.sublist(0, 20);
    }
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 50));
    return true;
  }

  @override
  void dispose() {
    horizontalAnimationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.animationController!,
      builder: (BuildContext context, Widget? child) {
        return FadeTransition(
          opacity: widget.animation!,
          child: Transform(
            transform: Matrix4.translationValues(
                0.0, 30 * (1.0 - widget.animation!.value), 0.0),
            child: Padding(
              padding: const EdgeInsets.only(
                left: 24,
                right: 24,
              ),
              child: Container(
                height: 160,
                width: double.infinity,
                child: FutureBuilder<bool>(
                  future: getData(),
                  builder:
                      (BuildContext context, AsyncSnapshot<bool> snapshot) {
                    if (!snapshot.hasData) {
                      return const SizedBox();
                    } else {
                      return ListView.builder(
                        itemCount: displayedMeals.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (BuildContext context, int index) {
                          final int count = displayedMeals.length > 10
                              ? 10
                              : displayedMeals.length;
                          final Animation<double> horizontalAnimation =
                              Tween<double>(begin: 0.0, end: 1.0).animate(
                                  CurvedAnimation(
                                      parent: horizontalAnimationController!,
                                      curve: Interval((1 / count) * index, 1.0,
                                          curve: Curves.fastOutSlowIn)));
                          horizontalAnimationController?.forward();

                          return Padding(
                            padding: _getMealCardPadding(
                                index, displayedMeals.length),
                            child: MealCard(
                              meal: displayedMeals[index],
                              animation: horizontalAnimation,
                              animationController:
                                  horizontalAnimationController,
                            ),
                          );
                        },
                      );
                    }
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  EdgeInsets _getMealCardPadding(int index, int listLength) {
    EdgeInsets padding;

    if (index == 0) {
      padding = const EdgeInsets.only(
        right: 12,
        left: 0, // No padding on the left for the first item
      );
    } else if (index == listLength - 1) {
      padding = const EdgeInsets.only(
        left: 12,
        right: 0, // No padding on the right for the last item
      );
    } else {
      padding = const EdgeInsets.symmetric(
        horizontal: 12,
      ); // Add padding on both sides for middle items
    }
    return padding;
  }
}
