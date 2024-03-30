import 'package:flutter/cupertino.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../config/themes/app_theme.dart';

class AppOnboardPageIndicator extends StatelessWidget {
  const AppOnboardPageIndicator({
    super.key,
    required this.currentPageIndex,
    required this.onDotClicked,
  });

  final int currentPageIndex;
  final Function(int index) onDotClicked;

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
      bottom: currentPageIndex == 4 ? -10.0 : 30.0,
      child: AnimatedSmoothIndicator(
        count: 5,
        activeIndex: currentPageIndex,
        onDotClicked: onDotClicked,
        effect: ExpandingDotsEffect(
          dotColor: AppTheme.lighterGrey.withOpacity(0.6),
          activeDotColor: AppTheme.darkGrey,
          dotHeight: 6.0,
        ),
      ),
    );
  }
}
