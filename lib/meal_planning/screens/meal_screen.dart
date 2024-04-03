import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_fridge/meal_planning/models/meal.dart';
import 'package:smart_fridge/src/config/math/scaler.dart';
import 'package:smart_fridge/src/config/themes/app_theme.dart';

class MealScreen extends StatefulWidget {
  final Meal meal;

  const MealScreen({
    super.key,
    required this.meal,
  });

  @override
  State<MealScreen> createState() => _MealScreenState();
}

class _MealScreenState extends State<MealScreen> {
  int currentNumber = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // bottomNavigationBar: Container(
      //   padding: const EdgeInsets.all(10),
      //   child: Row(
      //     children: [
      //       Expanded(
      //         flex: 6,
      //         child: ElevatedButton(
      //           onPressed: () {},
      //           style: ElevatedButton.styleFrom(
      //             backgroundColor: AppTheme.nearlyOrange,
      //             foregroundColor: Colors.white,
      //           ),
      //           child: const Text("Make Meal"),
      //         ),
      //       ),
      //       const SizedBox(width: 10),
      //       Expanded(
      //         child: IconButton(
      //           onPressed: () {},
      //           style: IconButton.styleFrom(
      //             shape: CircleBorder(
      //               side: BorderSide(
      //                 color: Colors.grey.shade300,
      //                 width: 2,
      //               ),
      //             ),
      //           ),
      //           icon: Icon(
      //             widget.meal.isFavourite ? Iconsax.heart : Iconsax.heart,
      //             color: widget.meal.isFavourite ? Colors.red : Colors.black,
      //             size: 20,
      //           ),
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
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
                        image: AssetImage(widget.meal.image),
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
                      MainActionButton(
                        icon: CupertinoIcons.chevron_back,
                        color: AppTheme.darkText,
                      ),
                      const Spacer(),
                      MainActionButton(
                        icon: widget.meal.isFavourite
                            ? Icons.favorite_outlined
                            : Icons.favorite_border_outlined,
                        color: widget.meal.isFavourite
                            ? AppTheme.nearlyRed
                            : AppTheme.grey,
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
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20),
                        topLeft: Radius.circular(20),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Center(
              child: Container(
                width: 50,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.meal.title,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const Icon(
                        Icons.access_time_filled,
                        size: 20,
                        color: Colors.grey,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        widget.meal.duration,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(width: 20),
                      const Icon(
                        Icons.text_snippet,
                        size: 20,
                        color: Colors.grey,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        widget.meal.stepsCount.toString(),
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Ingredients",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
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
                      Row(
                        children: [
                          Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              image: DecorationImage(
                                image: AssetImage(widget.meal.image),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            widget.meal.title,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                            textScaleFactor: Scaler.textScaleFactor(context),
                          ),
                          const Spacer(),
                          Text(
                            "400g",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey.shade400,
                            ),
                          )
                        ],
                      ),
                      Divider(
                        height: 20,
                        color: Colors.grey.shade300,
                      ),
                      Row(
                        children: [
                          Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              image: DecorationImage(
                                image: AssetImage(widget.meal.image),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          const Text(
                            "Ramen Noodles",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            "400g",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey.shade400,
                            ),
                          )
                        ],
                      ),
                      Divider(
                        height: 20,
                        color: Colors.grey.shade300,
                      ),
                      Row(
                        children: [
                          Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              image: DecorationImage(
                                image: AssetImage(widget.meal.image),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          const Text(
                            "Ramen Noodles",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            "400g",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey.shade400,
                            ),
                          )
                        ],
                      ),
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

class MainActionButton extends StatelessWidget {
  final IconData icon;
  final Color color;

  const MainActionButton({
    super.key,
    required this.icon,
    this.color = AppTheme.darkText,
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
            onPressed: () => Navigator.pop(context),
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
