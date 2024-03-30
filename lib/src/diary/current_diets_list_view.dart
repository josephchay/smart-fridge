import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smart_fridge/src/config/themes/app_theme.dart';
import 'package:smart_fridge/src/models/current_meal_diet_list_data.dart';

import '../../core/util/color.dart';

class CurrentDietsListView extends StatefulWidget {
  const CurrentDietsListView({
    super.key,
    this.mainScreenAnimationController,
    this.mainScreenAnimation,
  });

  final AnimationController? mainScreenAnimationController;
  final Animation<double>? mainScreenAnimation;

  @override
  _CurrentDietsListViewState createState() => _CurrentDietsListViewState();
}

class _CurrentDietsListViewState extends State<CurrentDietsListView>
    with TickerProviderStateMixin {
  AnimationController? animationController;
  List<CurrentDietsListData> currentDietsListData =
      CurrentDietsListData.tabIconsList;

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    super.initState();
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 50));
    return true;
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.mainScreenAnimationController!,
      builder: (BuildContext context, Widget? child) {
        return FadeTransition(
          opacity: widget.mainScreenAnimation!,
          child: Transform(
            transform: Matrix4.translationValues(
                0.0, 30 * (1.0 - widget.mainScreenAnimation!.value), 0.0),
            child: Container(
              height: 240,
              width: double.infinity,
              child: ListView.builder(
                padding: const EdgeInsets.only(
                  top: 0,
                  bottom: 0,
                  right: 16,
                  left: 16,
                ),
                itemCount: currentDietsListData.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  final int count = currentDietsListData.length > 10
                      ? 10
                      : currentDietsListData.length;
                  final Animation<double> animation =
                      Tween<double>(begin: 0.0, end: 1.0).animate(
                          CurvedAnimation(
                              parent: animationController!,
                              curve: Interval((1 / count) * index, 1.0,
                                  curve: Curves.fastOutSlowIn)));
                  animationController?.forward();

                  return MealDietView(
                    mealsListData: currentDietsListData[index],
                    animation: animation,
                    animationController: animationController!,
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}

class MealDietView extends StatelessWidget {
  const MealDietView({
    super.key,
    this.mealsListData,
    this.animationController,
    this.animation,
  });

  final CurrentDietsListData? mealsListData;
  final AnimationController? animationController;
  final Animation<double>? animation;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double tabWidth = screenWidth - (16 * 2);

    return AnimatedBuilder(
      animation: animationController!,
      builder: (BuildContext context, Widget? child) {
        return FadeTransition(
          opacity: animation!,
          child: Transform(
            transform: Matrix4.translationValues(
                100 * (1.0 - animation!.value), 0.0, 0.0),
            child: SizedBox(
              width: tabWidth,
              child: Stack(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 32,
                      left: 8,
                      right: 8,
                      bottom: 16,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: HexColor(mealsListData!.endColor)
                                .withOpacity(0.6),
                            offset: const Offset(1.1, 4.0),
                            blurRadius: 8.0,
                          ),
                        ],
                        gradient: LinearGradient(
                          colors: [
                            HexColor(mealsListData!.startColor),
                            HexColor(mealsListData!.endColor),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(12.0)),
                      ),
                      child: Stack(
                        children: [
                          Positioned(
                            top: 16, // Space from the top of the card
                            left: 0,
                            right: 0,
                            child: Text(
                              mealsListData!.titleTxt,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontFamily: AppTheme.fontName,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                letterSpacing: 0.6,
                                color: AppTheme.white,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 54,
                              left: 16,
                              right: 16,
                              bottom: 8,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 8, bottom: 8),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          mealsListData!.meals!.join('\n'),
                                          style: const TextStyle(
                                            fontFamily: AppTheme.fontName,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 13,
                                            letterSpacing: 0.4,
                                            color: AppTheme.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: <Widget>[
                                    if (mealsListData?.kcal != 0)
                                      Text(
                                        mealsListData!.kcal.toString(),
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          fontFamily: AppTheme.fontName,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 24,
                                          letterSpacing: 0.2,
                                          color: AppTheme.white,
                                        ),
                                      ),
                                    mealsListData?.kcal != 0
                                        ? const Padding(
                                            padding: EdgeInsets.only(
                                              left: 4,
                                              bottom: 3,
                                            ),
                                            child: Text(
                                              'kcal',
                                              style: TextStyle(
                                                fontFamily: AppTheme.fontName,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 10,
                                                letterSpacing: 0.2,
                                                color: AppTheme.white,
                                              ),
                                            ))
                                        : Padding(
                                            padding: const EdgeInsets.only(
                                              left: 4,
                                              bottom: 3,
                                            ),
                                            child: Text(
                                              'ON WAIT',
                                              style: TextStyle(
                                                fontFamily: AppTheme.fontName,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 13,
                                                letterSpacing: 0.2,
                                                color: AppTheme.nearlyWhite
                                                    .withOpacity(0.6),
                                              ),
                                            ),
                                          ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    left: 0,
                    child: Transform.rotate(
                      angle: 45 * pi / 180,
                      child: Container(
                        width: 84,
                        height: 84,
                        decoration: BoxDecoration(
                          color: AppTheme.nearlyWhite.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(34),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 40,
                    left: 30,
                    child: SizedBox(
                      width: 30,
                      height: 30,
                      child: SvgPicture.asset(
                        mealsListData!.imagePath,
                        color: AppTheme.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
