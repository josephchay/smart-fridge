import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:smart_fridge/meal_planning/models/meal.dart';
import 'package:smart_fridge/meal_planning/screens/meal_screen.dart';
import 'package:smart_fridge/src/config/math/scaler.dart';
import 'package:smart_fridge/src/config/themes/app_theme.dart';
import 'package:smart_fridge/utils/formatters/datetime.dart';

class AppMealPlannerRecommendations extends StatefulWidget {
  final Animation<double>? animation;
  final AnimationController? animationController;
  final Function()? callBack;

  const AppMealPlannerRecommendations({
    super.key,
    this.callBack,
    this.animation,
    this.animationController,
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

  void _prepareList() {
    if (recommendedMealList.length > 20) {
      displayedMeals = recommendedMealList.sublist(0, 20);
    } else {
      displayedMeals = recommendedMealList;
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

class MealCard extends StatelessWidget {
  final Meal meal;
  final AnimationController? animationController;
  final Animation<double>? animation;

  const MealCard({
    super.key,
    required this.meal,
    this.animationController,
    this.animation,
  });

  @override
  Widget build(BuildContext context) {
    double imageWidth = 130.0; // Fixed width for the image
    double imageHeight = 130.0; // Fixed height for the image
    double containerWidth = 280.0; // Fixed width for the container
    double contentOffsetFromImage = 10.0;

    return AnimatedBuilder(
      animation: animationController!,
      builder: (BuildContext context, Widget? child) {
        return FadeTransition(
          opacity: animation!,
          child: Transform(
            transform: Matrix4.translationValues(
                100 * (1.0 - animation!.value), 0.0, 0.0),
            child: InkWell(
              splashColor: Colors.transparent,
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MealScreen(
                    data: meal,
                  ),
                ),
              ),
              child: Container(
                width: containerWidth,
                child: Stack(
                  clipBehavior:
                      Clip.none, // Allows children to draw outside of the Stack
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(
                        left: imageWidth / 2 + contentOffsetFromImage / 2 - 10,
                      ), // Adjust the padding to make space for the image
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppTheme.white,
                          borderRadius: BorderRadius.all(Radius.circular(16.0)),
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(
                            left: imageWidth / 2 +
                                contentOffsetFromImage +
                                10, // Adjust for the part of the image sticking out
                            top: 14.0,
                            right: 16.0,
                            bottom: 14.0,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                meal!.name,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                  letterSpacing: 0.27,
                                  color: AppTheme.darkerText,
                                ),
                                textScaleFactor:
                                    Scaler.textScaleFactor(context),
                              ),
                              const Expanded(
                                child: SizedBox(),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  right: 16,
                                  bottom: 8,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    CardSubInfo(
                                      text: AppDatetime
                                          .fromMinutesToFormattedHourMinute(
                                              meal!.preparationMinutes),
                                      icon: Icons.access_time_filled,
                                    ),
                                    CardSubInfo(
                                      text: meal!.nSteps.toString(),
                                      icon: Icons.text_snippet,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 12,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(
                                  0.2), // Adjust color opacity as needed
                              spreadRadius: 0,
                              blurRadius: 6,
                              offset:
                                  Offset(0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16.0),
                          child: Image.asset(
                            meal!.image,
                            fit: BoxFit.cover,
                            width: imageWidth,
                            height: imageHeight,
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
  final String text;
  final IconData icon;

  const CardSubInfo({
    super.key,
    required this.text,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(
              right: 2,
            ),
            child: Icon(
              icon,
              color: AppTheme.lighterGrey.withOpacity(.8),
              size: 16 * Scaler.textScaleFactor(context),
            ),
          ),
          Text(
            text,
            textAlign: TextAlign.left,
            style: TextStyle(
              fontWeight: FontWeight.w200,
              fontSize: 13,
              letterSpacing: 0.27,
              color: AppTheme.lighterGrey,
            ),
            textScaleFactor: Scaler.textScaleFactor(context),
          ),
        ],
      ),
    );
  }
}
