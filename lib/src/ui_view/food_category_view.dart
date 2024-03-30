import 'package:flutter/material.dart';
import 'package:smart_fridge/src/models/food_category.dart';

class FoodCategoryView extends StatelessWidget {
  final AnimationController? animationController;
  final Animation<double>? animation;

  FoodCategoryView({
    super.key,
    this.animationController,
    this.animation,
  });

  List<FoodCategory> categories = FoodCategory.categories;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController!,
      builder: (BuildContext context, Widget? child) {
        return FadeTransition(
          opacity: animation!,
          child: Transform(
            transform: Matrix4.translationValues(
                0.0, 30 * (1.0 - animation!.value), 0.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ListView.builder(
                  itemCount: categories.length,
                  itemBuilder: (BuildContext ctx, int index) {
                    return Container(
                      margin: EdgeInsets.all(20),
                      height: 150,
                      child: Stack(
                        children: [],
                      ),
                    );
                  },
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
