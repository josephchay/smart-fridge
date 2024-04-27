import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:liquid_swipe/liquid_swipe.dart";
import "package:smart_fridge/meal_planning/models/meal.dart";
import 'package:smart_fridge/src/features/onboarding/widgets/onboarding_controller.dart';
import "package:smart_fridge/src/features/onboarding/widgets/page_indicator.dart";
import "package:smart_fridge/src/features/onboarding/widgets/swipe_next_button.dart";
import "package:smart_fridge/src/features/onboarding/widgets/swipe_previous_button.dart";

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({
    super.key,
  });

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  @override
  void initState() {
    if (latestMealList.isEmpty) {
      loadMeals('assets/datasets/meals.csv');
    }
    super.initState();
  }

  Widget build(BuildContext context) {
    final controller = OnboardingController();

    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          LiquidSwipe(
            waveType: WaveType.liquidReveal,
            pages: controller.pages,
            fullTransitionValue: 600,
            liquidController: controller.pageController,
            onPageChangeCallback: controller.onPageChangeCallback,
            enableLoop: false,
            // enableSideReveal: false,
            // slideIconWidget: Icon(Iconsax.arrow_right_3),
          ),
          Obx(
            () => AnimatedOpacity(
              // Only visible starting from the second page (index 1)
              opacity: controller.currentPageIndex.value > 0 ? 1.0 : 0.0,
              duration:
                  const Duration(milliseconds: 300), // Transition duration
              child: AppOnboardSwipePreviousButton(
                onPressed: () => controller.animateToPreviousPage(context),
                currentPageIndex: controller.currentPageIndex.value,
              ),
            ),
          ),
          Obx(
            () => OnboardingPageIndicator(
              currentPageIndex: controller.currentPageIndex.value,
              onDotClicked: controller.onDotClicked,
            ),
          ),
          Obx(
            () => OnboardingSwipeNextButton(
              onPressed: () => controller.animateToNextPage(context, false),
              onLoginPressed: () => controller.animateToNextPage(context, true),
              currentPageIndex: controller.currentPageIndex.value,
            ),
          ),
        ],
      ),
    );
  }
}
