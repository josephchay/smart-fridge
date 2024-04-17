import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_fridge/meal_planning/models/meal.dart';
import 'package:smart_fridge/src/config/math/scaler.dart';
import 'package:smart_fridge/src/config/themes/app_theme.dart';
import 'package:smart_fridge/utils/formatters/datetime.dart';
import 'package:smart_fridge/utils/formatters/strings.dart';

class MealScreen extends StatefulWidget {
  final Meal data;

  const MealScreen({
    super.key,
    required this.data,
  });

  @override
  State<MealScreen> createState() => _MealScreenState();
}

class _MealScreenState extends State<MealScreen> {
  int currentNumber = 1;
  bool isMakingMeal = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            Expanded(
              flex: 10,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      isMakingMeal = !isMakingMeal;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.nearlyOrange,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: Text(
                    isMakingMeal ? "Stop Making" : "Make Meal",
                    style: TextStyle(
                      fontSize: 16 * Scaler.textScaleFactor(context),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Positioned(
                  child: Container(
                    height: MediaQuery.of(context).size.width - 20,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(widget.data.image ?? ""),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 40,
                  left: 10,
                  right: 10,
                  child: Row(
                    children: [
                      TopActionButton(
                        icon: CupertinoIcons.chevron_back,
                        color: AppTheme.darkText,
                        onPressed: () => Navigator.pop(context),
                      ),
                      const Spacer(),
                      TopActionButton(
                        icon: widget.data.isFavorite
                            ? Icons.favorite_outlined
                            : Icons.favorite_border_outlined,
                        color: widget.data.isFavorite
                            ? AppTheme.nearlyRed
                            : AppTheme.grey,
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  top: MediaQuery.of(context).size.width - 50,
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: const BoxDecoration(
                      color: AppTheme.white,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20),
                        topLeft: Radius.circular(20),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            // Center(
            //   child: Container(
            //     width: 50,
            //     height: 5,
            //     decoration: BoxDecoration(
            //       color: Colors.grey.shade300,
            //       borderRadius: BorderRadius.circular(20),
            //     ),
            //   ),
            // ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.data.name ?? "Currently Not Available",
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Icon(
                        Icons.access_time_filled,
                        size: 20 * Scaler.textScaleFactor(context),
                        color: Colors.grey,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        AppDatetime.fromMinutesToFormattedHourMinute(
                          widget.data.preparationMinutes ?? 0,
                        ),
                        style: TextStyle(
                          fontSize: 14 * Scaler.textScaleFactor(context),
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(width: 20),
                      Icon(
                        Icons.text_snippet,
                        size: 20 * Scaler.textScaleFactor(context),
                        color: Colors.grey,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        widget.data.nSteps.toString(),
                        style: TextStyle(
                          fontSize: 14 * Scaler.textScaleFactor(context),
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(width: 20),
                      Icon(
                        Icons.grain,
                        size: 20 * Scaler.textScaleFactor(context),
                        color: Colors.grey,
                      ),
                      Text(
                        "${widget.data.ingredients!.length}",
                        style: TextStyle(
                          fontSize: 14 * Scaler.textScaleFactor(context),
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_month,
                        size: 20 * Scaler.textScaleFactor(context),
                        color: Colors.grey,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        widget.data.submitted,
                        style: TextStyle(
                          fontSize: 14 * Scaler.textScaleFactor(context),
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Steps",
                            style: TextStyle(
                              fontSize: 20 * Scaler.textScaleFactor(context),
                              fontWeight: FontWeight.bold,
                              color: AppTheme.nearlyOrange,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      for (int i = 0; i < widget.data.steps!.length; i++) ...[
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                '${i + 1}.', // Step number, starting from 1
                                style: TextStyle(
                                  fontSize:
                                      16 * Scaler.textScaleFactor(context),
                                  color: i % 2 == 0
                                      ? AppTheme.deactivatedText
                                      : AppTheme.deactivatedText
                                          .withOpacity(0.6),
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                AppStrings.capitalizeFirstOfSentence(
                                        widget.data.steps![i]) +
                                    ".", // Step description
                                style: TextStyle(
                                  fontSize:
                                      16 * Scaler.textScaleFactor(context),
                                  color: i % 2 == 0
                                      ? AppTheme.deactivatedText
                                      : AppTheme.deactivatedText
                                          .withOpacity(0.6),
                                ),
                              ),
                            ),
                          ],
                        ),
                        if (i !=
                            widget.data.steps!.length -
                                1) // Check if it's not the last element
                          Divider(
                            height: 30,
                            color: Colors.grey.shade300,
                          ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        // Makes the "Ingredients" text flexible
                        flex: 2,
                        child: Text(
                          "Ingredients",
                          style: TextStyle(
                            fontSize: 20 * Scaler.textScaleFactor(context),
                            fontWeight: FontWeight.bold,
                            color: AppTheme.nearlyOrange,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Flexible(
                        // Makes the ingredients count text flexible
                        flex: 1,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: AppTheme.nearlyOrange,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            "${widget.data.ingredients!.length} / ${widget.data.nIngredients}",
                            style: TextStyle(
                              fontSize: 14 * Scaler.textScaleFactor(context),
                              color: Colors.white,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      for (int i = 0;
                          i < widget.data.ingredients!.length;
                          i++) ...[
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                '${i + 1}.', // Step number, starting from 1
                                style: TextStyle(
                                  fontSize:
                                      16 * Scaler.textScaleFactor(context),
                                  color: AppTheme.deactivatedText,
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            if (widget.data.ingredients![i].isNotEmpty)
                              Expanded(
                                child: Text(
                                  AppStrings.capitalizeFirstOfSentence(
                                          widget.data.ingredients![i]) +
                                      ".", // Step description
                                  style: TextStyle(
                                    fontSize:
                                        16 * Scaler.textScaleFactor(context),
                                    color: AppTheme.deactivatedText,
                                  ),
                                ),
                              ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Icon(
                                Icons.check_circle,
                                color: AppTheme.nearlyGreen,
                                size: 24 * Scaler.textScaleFactor(context),
                              ),
                            ),
                          ],
                        ),
                        if (i !=
                            widget.data.ingredients!.length -
                                1) // Check if it's not the last element
                          Divider(
                            height: 30,
                            color: Colors.grey.shade300,
                          ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TopActionButton extends StatelessWidget {
  final IconData icon;
  final Color color;
  final Function()? onPressed;

  const TopActionButton({
    super.key,
    required this.icon,
    this.color = AppTheme.darkText,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(
          15), // Match this to your IconButton's borderRadius
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
        child: Container(
          decoration: BoxDecoration(
            color: AppTheme.white.withOpacity(0.4),
            borderRadius: BorderRadius.circular(15),
          ),
          child: IconButton(
            onPressed: () => onPressed!(),
            icon: Icon(
              icon,
              color: color,
            ),
            // Remove the styleFrom if using a Container for background styling
          ),
        ),
      ),
    );
  }
}
