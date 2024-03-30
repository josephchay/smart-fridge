import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:liquid_swipe/liquid_swipe.dart";
import 'package:smart_fridge/src/features/onboarding/widgets/onboarding_controller.dart';

import '../widgets/page_indicator.dart';
import '../widgets/swipe_next_button.dart';
import '../widgets/swipe_previous_button.dart';

class AppOnboardingScreen extends StatelessWidget {
  const AppOnboardingScreen({
    super.key,
  });

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
            () => AppOnboardSwipePreviousButton(
              onPressed: () => controller.animateToPreviousPage(context),
              currentPageIndex: controller.currentPageIndex.value,
            ),
          ),
          Obx(
            () => AppOnboardPageIndicator(
              currentPageIndex: controller.currentPageIndex.value,
              onDotClicked: controller.onDotClicked,
            ),
          ),
          Obx(
            () => AppOnboardSwipeNextButton(
              onSignupPressed: () =>
                  controller.animateToNextPage(context, false),
              onLoginPressed: () => controller.animateToNextPage(context, true),
              currentPageIndex: controller.currentPageIndex.value,
            ),
          ),
        ],
      ),
    );
  }
}
