import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:smart_fridge/meal_planning/models/meal.dart';
import 'package:smart_fridge/meal_planning/screens/meal_screen.dart';
import 'package:smart_fridge/src/config/math/scaler.dart';
import 'package:smart_fridge/src/config/themes/app_theme.dart';

class AppMealPlannerTrending extends StatefulWidget {
  final Animation<double>? animation;
  final AnimationController? animationController;

  const AppMealPlannerTrending({
    super.key,
    this.animation,
    this.animationController,
  });

  @override
  State<AppMealPlannerTrending> createState() => _AppMealPlannerTrendingState();
}

class _AppMealPlannerTrendingState extends State<AppMealPlannerTrending>
    with TickerProviderStateMixin {
  AnimationController? horizontalAnimationController;

  @override
  void initState() {
    super.initState();
    horizontalAnimationController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 450));
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
                height: 200,
                width: double.infinity,
                child: FutureBuilder<bool>(
                  future: getData(),
                  builder:
                      (BuildContext context, AsyncSnapshot<bool> snapshot) {
                    if (!snapshot.hasData) {
                      return const SizedBox();
                    } else {
                      return ListView.builder(
                        itemCount: recommendedMealList.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (BuildContext context, int index) {
                          final int count = recommendedMealList.length > 10
                              ? 10
                              : recommendedMealList.length;
                          final Animation<double> horizontalAnimation =
                              Tween<double>(begin: 0.0, end: 1.0).animate(
                                  CurvedAnimation(
                                      parent: horizontalAnimationController!,
                                      curve: Interval((1 / count) * index, 1.0,
                                          curve: Curves.fastOutSlowIn)));
                          horizontalAnimationController?.forward();

                          return Padding(
                            padding: _getMealCardPadding(
                                index, trendingMealList.length),
                            child: MealCard(
                              meal: trendingMealList[index],
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

  const MealCard({
    super.key,
    required this.meal,
    this.animation,
    this.animationController,
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
                    meal: meal,
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
                              image: AssetImage(meal.image),
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
                          meal.title,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                          textScaleFactor: Scaler.textScaleFactor(
                              context), // Adjust text size based on screen size
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            CardSubInfo(
                              text: meal.duration,
                              icon: Icons.access_time_filled,
                            ),
                            CardSubInfo(
                              text: meal.stepsCount.toString(),
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
                                meal.isFavourite
                                    ? Icons.favorite_outlined
                                    : Icons.favorite_border_outlined,
                                // check if the current meal is in the favorites list
                                color: meal.isFavourite
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
