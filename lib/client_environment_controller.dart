import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:smart_fridge/custom_drawer/drawer.dart';
import 'package:smart_fridge/fridge/ui/screen.dart';
import 'package:smart_fridge/grocery_listings/screen.dart';
import 'package:smart_fridge/meal_planning/screen.dart';
import 'package:smart_fridge/src/bottom_navigation_view/navigation_bar_view.dart';
import 'package:smart_fridge/src/config/themes/app_theme.dart';
import 'package:smart_fridge/src/diary/screen.dart';
import 'package:smart_fridge/src/features/notifications/presentation/notification_screen.dart';
import 'package:smart_fridge/src/models/navigation_bar_icon.dart';

/// Front controller of the app after the successful login attempt.
class AppClientEnvironmentController extends StatefulWidget {
  final Function(double x, double y, double scale, double angle)? onDrawerSlide;

  const AppClientEnvironmentController({
    super.key,
    this.onDrawerSlide,
  });

  @override
  _AppClientEnvironmentControllerState createState() =>
      _AppClientEnvironmentControllerState();
}

class _AppClientEnvironmentControllerState
    extends State<AppClientEnvironmentController>
    with TickerProviderStateMixin {
  late AnimationController _drawerAnimationController;
  late Animation<double> animation;
  late Animation<double> animationScale;
  // late Animation<double> animationBorderRadius;
  bool focusedView = false;

  // The onboarding animation of the page
  AnimationController? pageAnimationController;

  Map<String, AppNavigationBarIcon> navigationBarIcons =
      AppNavigationBarIcon.navigationBarIcons;

  late ScrollController _scrollController;
  double _lastScrollPosition = 0.0;

  late AnimationController navBarAnimationController;
  late Animation<Offset> navBarSlideAnimation;

  Widget tabBody = Container(
    color: AppTheme.background,
  );

  double xOffset = 0;
  double yOffset = 0;
  double scaleFactor = 1;
  double rotationAngle = 0;
  bool isDrawerCloseBool = true;

  @override
  void initState() {
    super.initState();

    navBarAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    navBarSlideAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: Offset(0, 1), // Slide up
    ).animate(
      CurvedAnimation(
        parent: navBarAnimationController,
        curve: Cubic(0.87, 0, 0.13, 1),
      ),
    );

    _scrollController = ScrollController()
      ..addListener(() {
        if (isDrawerCloseBool) {
          // Check if the drawer is closed
          double currentScrollPosition = _scrollController.position.pixels;
          toggleNavBarVisibility(currentScrollPosition > _lastScrollPosition);
          _lastScrollPosition = currentScrollPosition;
        }
      });

    navigationBarIcons.forEach((key, AppNavigationBarIcon tab) {
      tab.isSelected = false;
    });

    navigationBarIcons['grocery']?.isSelected = true;

    _drawerAnimationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    )..addListener(() {
        setState(() {});
      });

    animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _drawerAnimationController,
        curve: Curves.fastOutSlowIn,
      ),
    );
    animationScale = Tween<double>(begin: 1, end: 0.8).animate(
      CurvedAnimation(
        parent: _drawerAnimationController,
        curve: Curves.fastOutSlowIn,
      ),
    );
    // animationBorderRadius = BorderRadiusTween(
    //   begin: BorderRadius.circular(0.0),
    //   end: BorderRadius.circular(26.0),
    // ).animate(
    //   CurvedAnimation(
    //       parent: _drawerAnimationController, curve: Curves.easeInOut),
    // ) as Animation<double>
    //   ..addListener(() {
    //     setState(() {});
    //   });

    pageAnimationController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    tabBody = GroceryScreen();

    // if (widget.onDrawerSlide != null) {
    //   widget.onDrawerSlide!(updatePosition());
    // }
  }

  // List<double> updatePosition(double x, double y, double scale, double angle) {
  //   setState(() {
  //     xOffset = x;
  //     yOffset = y;
  //     scaleFactor = scale;
  //     rotationAngle = angle;
  //   });

  //   return [xOffset, yOffset, scaleFactor, rotationAngle];
  // }

  @override
  void dispose() {
    navBarAnimationController.dispose();
    _scrollController.dispose();
    _drawerAnimationController.dispose();
    pageAnimationController?.dispose();
    super.dispose();
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // transform: Matrix4.translationValues(xOffset, yOffset, 0)
      //   ..scale(scaleFactor)
      //   ..rotateZ(rotationAngle),
      // duration: Duration(milliseconds: 200),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppTheme.nearlyOrange,
            AppTheme.nearlyTiger,
          ],
        ),
      ),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        extendBody: true,
        backgroundColor: Colors.transparent,
        body: FutureBuilder<bool>(
          future: getData(),
          builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
            if (!snapshot.hasData) {
              return const SizedBox();
            } else {
              return Stack(
                children: <Widget>[
                  AnimatedPositioned(
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.fastOutSlowIn,
                    width: 288,
                    height: MediaQuery.of(context).size.height,
                    left: isDrawerCloseBool ? -288 : 0,
                    child: const AppDrawer(),
                  ),
                  Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.identity()
                      ..setEntry(3, 2, 0.001)
                      ..rotateY(animation.value -
                          30 * animation.value * math.pi / 180),
                    child: Transform.translate(
                      offset: Offset(animation.value * 265, 0),
                      child: Transform.scale(
                        scale: animationScale.value,
                        child: ClipRRect(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(26.0)),
                          child: GestureDetector(
                            onTap: () {
                              if (!isDrawerCloseBool) {
                                _drawerAnimationController.reverse();
                                setState(() {
                                  isDrawerCloseBool = true;
                                });
                              }
                            },
                            // Wrap tabBody in AbsorbPointer to disable its interaction when drawer is open
                            child: AbsorbPointer(
                              absorbing: !isDrawerCloseBool,
                              child: tabBody,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Transform.translate(
                    offset: Offset(
                        0,
                        focusedView
                            ? MediaQuery.of(context).size.height - 60
                            : animation.value * 120),
                    child: SlideTransition(
                      position: navBarSlideAnimation,
                      child: navigationBar(),
                    ),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }

  void toggleNavBarVisibility(bool visible) {
    if (visible) {
      navBarAnimationController.forward();
    } else {
      navBarAnimationController.reverse();
    }
  }

  Widget navigationBar() {
    return Column(
      children: <Widget>[
        const Expanded(
          child: SizedBox(),
        ),
        SafeArea(
          child: AppNavigationBarView(
            addClick: () {},
            onLongPress: () {
              isDrawerCloseBool
                  ? _drawerAnimationController.forward()
                  : _drawerAnimationController.reverse();

              setState(() {
                isDrawerCloseBool = !isDrawerCloseBool;
              });
            },
            changeIndex: (int index) {
              pageAnimationController?.reverse().then<dynamic>((data) {
                if (!mounted) {
                  return;
                }

                setState(() {
                  switch (index) {
                    case 0:
                      tabBody = DiaryScreen();
                      break;
                    case 1:
                      tabBody = GroceryScreen();
                      break;
                    case 2:
                      tabBody = CameraScreen();
                      break;
                    case 3:
                      tabBody = NotificationScreen(
                        animationController: pageAnimationController,
                        scrollController: _scrollController,
                      );
                      break;
                    case 4:
                      tabBody = AppMealPlannerScreen(
                        animationController: pageAnimationController,
                        scrollController: _scrollController,
                      );
                      break;
                    default:
                      break;
                  }
                });
              });
            },
            navigationBarIcons: navigationBarIcons,
          ),
        ),
      ],
    );
  }
}
