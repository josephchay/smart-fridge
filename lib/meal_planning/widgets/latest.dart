import 'dart:ui';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:smart_fridge/meal_planning/models/meal.dart';
import 'package:smart_fridge/meal_planning/screens/meal_screen.dart';
import 'package:smart_fridge/src/config/math/scaler.dart';
import 'package:smart_fridge/src/config/themes/app_theme.dart';
import 'package:smart_fridge/utils/formatters/datetime.dart';

class AppMealPlannerLatest extends StatefulWidget {
  final Animation<double>? animation;
  final AnimationController? animationController;

  const AppMealPlannerLatest({
    super.key,
    this.animation,
    this.animationController,
  });

  @override
  State<AppMealPlannerLatest> createState() => _AppMealPlannerLatestState();
}

class _AppMealPlannerLatestState extends State<AppMealPlannerLatest>
    with TickerProviderStateMixin {
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

  void _prepareList() {
    if (latestMealList.length > 20) {
      displayedMeals = latestMealList.sublist(0, 20);
    } else {
      displayedMeals = latestMealList;
    }
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 250));
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
                height: 240,
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
        right: 8,
        left: 0, // No padding on the left for the first item
      );
    } else if (index == listLength - 1) {
      padding = const EdgeInsets.only(
        left: 8,
        right: 0, // No padding on the right for the last item
      );
    } else {
      padding = const EdgeInsets.symmetric(
        horizontal: 8,
      ); // Add padding on both sides for middle items
    }
    return padding;
  }
}

class MealCard extends StatelessWidget {
  final Meal meal;
  final Animation<double>? animation;
  final AnimationController? animationController;
  final bool displaySubInfo;
  final bool textEllipsis;

  const MealCard({
    super.key,
    required this.meal,
    this.animation,
    this.animationController,
    this.displaySubInfo = true,
    this.textEllipsis = false,
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
                100 * (1.0 - animation!.value), 0.0, 0.0),
            child: GestureDetector(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MealScreen(
                    data: meal,
                  ),
                ),
              ),
              child: Container(
                margin: const EdgeInsets.only(
                  right: 10,
                ),
                width: 200,
                child: Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: double.infinity,
                          height: 130,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            image: DecorationImage(
                              image: AssetImage(meal.image ?? ''),
                              fit: BoxFit.cover,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                // Adjust color opacity as needed
                                spreadRadius: 0,
                                blurRadius: 6,
                                offset:
                                    Offset(0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          meal.name ?? '',
                          style: TextStyle(
                            fontSize: textEllipsis ? 14 : 16,
                            fontWeight: FontWeight.bold,
                          ),
                          textScaleFactor: Scaler.textScaleFactor(context),
                          maxLines: textEllipsis ? 1 : null,
                          overflow: textEllipsis ? TextOverflow.ellipsis : null,
                        ),
                        if (displaySubInfo) const SizedBox(height: 10),
                        if (displaySubInfo)
                          Row(
                            children: [
                              CardSubInfo(
                                text: AppDatetime
                                    .fromMinutesToFormattedHourMinute(
                                  meal.preparationMinutes ?? 0,
                                ),
                                icon: Icons.access_time_filled,
                              ),
                              CardSubInfo(
                                text: meal.nSteps.toString(),
                                icon: Icons.text_snippet,
                              ),
                            ],
                          ),
                      ],
                    ),
                    Positioned(
                      top: 6,
                      right: 6,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(
                            12.0), // Radius of the rounded corners
                        child: BackdropFilter(
                          filter: ImageFilter.blur(
                              sigmaX: 6.0,
                              sigmaY: 6.0), // The blur effect values
                          child: Container(
                            width: 36,
                            height: 36,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(
                                  0.4), // Semi-transparent white background
                              borderRadius: BorderRadius.circular(
                                  12.0), // Radius of the rounded corners
                            ),
                            child: IconButton(
                              iconSize: 20 * Scaler.textScaleFactor(context),
                              onPressed: () {},
                              icon: Icon(
                                meal.isFavorite
                                    ? Icons.favorite_outlined
                                    : Icons.favorite_border_outlined,
                                // check if the current meal is in the favorites list
                                color: meal.isFavorite
                                    ? AppTheme.nearlyRed
                                    : AppTheme.grey.withOpacity(.8),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
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

class CardSubInfo extends StatelessWidget {
  final IconData icon;
  final String text;
  final double iconSize = 18.0;
  final double fontSize = 14.0;

  const CardSubInfo({
    super.key,
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          size: iconSize,
          color: AppTheme.lighterGrey,
        ),
        const SizedBox(width: 4),
        Text(
          text,
          style: TextStyle(
            fontSize: fontSize,
            color: AppTheme.lighterGrey,
          ),
        ),
        const SizedBox(width: 10),
      ],
    );
  }
}
