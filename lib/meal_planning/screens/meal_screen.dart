import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:smart_fridge/meal_planning/models/meal.dart';
import 'package:smart_fridge/config/math/scaler.dart';
import 'package:smart_fridge/config/themes/app_theme.dart';
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
  final FlutterTts flutterTts = FlutterTts();

  speak(String text) async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.setPitch(1);
    await flutterTts.speak(text);
  }

  int currentNumber = 1;
  int stepCountReading =
      0; // Initialize the step counter of the step that is being currently read by tts
  bool isMakingMeal = false;

  @override
  void dispose() {
    flutterTts.stop();
    super.dispose();
  }

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
                  onPressed: () async {
                    if (isMakingMeal) {
                      // If currently making a meal, stop the TTS and toggle the state.
                      await flutterTts.stop();
                      setState(() {
                        isMakingMeal = false;
                        stepCountReading = 0; // Reset step count when stopping
                      });
                    } else {
                      // Set makingMeal to true at the start of the process.
                      setState(() {
                        isMakingMeal = true;
                        stepCountReading =
                            1; // Ensure starting from the first step
                      });
                      for (var step in widget.data.steps) {
                        if (!isMakingMeal)
                          break; // Ensures we stop if isMakingMeal is toggled off
                        setState(() {
                          stepCountReading = widget.data.steps.indexOf(step) +
                              1; // Update currently reading step
                        });
                        String textToSpeak = "Step $stepCountReading. ${step}";
                        await flutterTts.speak(textToSpeak);
                        await flutterTts.awaitSpeakCompletion(true);
                      }
                      // Check again after finishing the loop in case the state was not changed by stopping.
                      if (isMakingMeal) {
                        setState(() {
                          isMakingMeal = false;
                          stepCountReading =
                              0; // Reset step count when finished
                        });
                      }
                    }
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
                        onPressed: () async {
                          await flutterTts.stop();
                          setState(() {
                            isMakingMeal = false;
                          });
                          Navigator.pop(context);
                        },
                      ),
                      const Spacer(),
                      // TopActionButton(
                      //   icon: widget.data.isFavorite
                      //       ? Icons.favorite_outlined
                      //       : Icons.favorite_border_outlined,
                      //   color: widget.data.isFavorite
                      //       ? AppTheme.nearlyRed
                      //       : AppTheme.grey,
                      //   onPressed: () async {},
                      // ),
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
                                  color: (i + 1 == stepCountReading)
                                      ? AppTheme.nearlyDarkOrange
                                      : i % 2 == 0
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
                                  color: (i + 1 == stepCountReading)
                                      ? AppTheme.nearlyDarkOrange
                                      : i % 2 == 0
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
                            "0 / ${widget.data.nIngredients}",
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
                            // Padding(
                            //   padding: const EdgeInsets.only(left: 10),
                            //   child: Icon(
                            //     Icons.add_circle_outline,
                            //     color: AppTheme.grey.withOpacity(0.6),
                            //     size: 24 * Scaler.textScaleFactor(context),
                            //   ),
                            // ),
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
  final Future<void> Function() onPressed;

  const TopActionButton({
    super.key,
    required this.icon,
    required this.color,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
        child: Container(
          decoration: BoxDecoration(
            color: AppTheme.white.withOpacity(0.4),
            borderRadius: BorderRadius.circular(15),
          ),
          child: IconButton(
            icon: Icon(icon, color: color),
            onPressed: () async {
              await onPressed(); // Make sure to await the onPressed function
            },
          ),
        ),
      ),
    );
  }
}
