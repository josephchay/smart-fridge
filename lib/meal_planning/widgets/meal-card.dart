import 'package:flutter/material.dart';
import 'package:smart_fridge/meal_planning/models/meal.dart';
import 'package:smart_fridge/meal_planning/screens/meal_screen.dart';
import 'package:smart_fridge/src/config/math/scaler.dart';
import 'package:smart_fridge/src/config/themes/app_theme.dart';
import 'package:smart_fridge/utils/formatters/datetime.dart';

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
                                meal.name ?? "",
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
                                              meal.preparationMinutes ?? 0),
                                      icon: Icons.access_time_filled,
                                    ),
                                    CardSubInfo(
                                      text: meal.nSteps.toString(),
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
                            meal!.image ?? "",
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
              fontSize: 13 * Scaler.textScaleFactor(context),
              letterSpacing: 0.27,
              color: AppTheme.lighterGrey,
            ),
          ),
        ],
      ),
    );
  }
}
