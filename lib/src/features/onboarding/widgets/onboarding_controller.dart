import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:liquid_swipe/PageHelpers/LiquidController.dart';
import 'package:smart_fridge/src/config/themes/app_theme.dart';
import 'package:smart_fridge/src/features/authentication/presentation/screen.dart';
import 'package:smart_fridge/src/features/onboarding/widgets/onboarding_page_widget.dart';

import '../../../../core/util/color.dart';
import '../../authentication/data/models/onboarding/onboarding_model.dart';

class OnboardingController extends GetxController {
  final pageController = LiquidController();
  RxInt currentPageIndex = 0.obs; // used with set state, make observable.
  RxBool isLastPage = false.obs;

  final pages = [
    OnboardingPageWidget(
      model: OnboardingModel(
        image: "assets/images/onboarding/vision_from_within.png",
        title: "Vision from Within",
        description:
            "Peek into your fridge and liberate it from isolation while effortlessly managing your fridge's contents anytime, anywhere!",
        number: "1/5",
        bgColors: [
          HexColor("#95FAFF"),
          // HexColor("#FFC584"),
          AppTheme.nearlyWhite,
        ],
      ),
    ),
    OnboardingPageWidget(
      model: OnboardingModel(
        image: "assets/images/onboarding/smart_shopper_assistant_3.png",
        title: "Smart Shopper Assistant",
        description:
            "Seamless customized grocery list synced with your fridge for smarter shopping!",
        number: "2/5",
        bgColors: [
          AppTheme.nearlyWhite,
          HexColor("#D2FFB9"),
          // HexColor("#FFC5F1"),
        ],
      ),
    ),
    OnboardingPageWidget(
      model: OnboardingModel(
        image: "assets/images/onboarding/on_sentinal_alert.png",
        title: "On Sentinel Alert",
        description:
            "Stay informed with real-time alerts on events around your fridge!",
        number: "3/5",
        bgColors: [
          HexColor("#FFD6D6"),
          // HexColor("#B4FFFE"),
          AppTheme.nearlyWhite,
        ],
      ),
    ),
    OnboardingPageWidget(
      model: OnboardingModel(
        image: "assets/images/onboarding/savvy_culinary_companion_2.png",
        title: "Savvy Culinary Companion",
        description:
            "Transform your ingredients into culinary magic! From fridge to table effortlessly with what you have!",
        number: "4/5",
        bgColors: [
          AppTheme.nearlyWhite,
          HexColor("#FFE979"),
          // HexColor("#FCFFAD"),
          // HexColor("#FFCEC0"),
        ],
      ),
    ),
    OnboardingPageWidget(
      model: OnboardingModel(
        image: "assets/images/onboarding/fridge_betterment_2.png",
        title: "Fridge Betterment",
        description:
            'Step into the future of fridge convenience technology. Start Your Smart Fridge Adventure Today!',
        number: "5/5",
        bgColors: [
          HexColor("#EEBEFF"),
          // HexColor("#FFE79D"),
          AppTheme.nearlyWhite,
        ],
      ),
    ),
  ];

  void onDotClicked(index) {
    currentPageIndex.value = index;
    pageController.jumpToPage(
      page: index,
    );
    // animatedToPage(index);
  }

  void animateToPreviousPage(BuildContext context) {
    int previousPageIndex = pageController.currentPage - 1;
    animatedToPage(previousPageIndex);
  }

  void animateToNextPage(BuildContext context, bool isLogin) {
    if (currentPageIndex.value == 4) {
      final storage = GetStorage();
      storage.write('isFirstTime', false);

      Get.offAll(() => AuthScreen(isLogin: isLogin));
      // Navigator.pushReplacement(
      //   context,
      //   MaterialPageRoute(
      //       builder: (context) => AppAuthScreen(isLogin: isLogin)),
      // );
      if (!isLastPage.value) {
        isLastPage.value = true;
      }

      return;
    }

    if (isLastPage.value) {
      isLastPage.value = false;
    }

    int nexPage = pageController.currentPage + 1;
    animatedToPage(nexPage);
  }

  void animatedToPage(int page) {
    pageController.animateToPage(
      page: page,
      duration: 600,
    );
  }

  void onPageChangeCallback(int index) {
    currentPageIndex.value = index;
  }

  void skipPage() {}
}
