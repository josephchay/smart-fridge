import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smart_fridge/src/config/themes/app_theme.dart';
import 'package:smart_fridge/src/models/navigation_bar_icon.dart';

import '../../core/util/color.dart';

class AppNavigationBarView extends StatefulWidget {
  final Function(int index)? changeIndex;
  final Function()? addClick;
  final Function()? onLongPress;
  final Map<String, AppNavigationBarIcon>? navigationBarIcons;

  const AppNavigationBarView({
    Key? key,
    this.changeIndex,
    this.addClick,
    this.onLongPress,
    this.navigationBarIcons,
  }) : super(key: key);

  @override
  _AppNavigationBarViewState createState() => _AppNavigationBarViewState();
}

class _AppNavigationBarViewState extends State<AppNavigationBarView>
    with TickerProviderStateMixin {
  AnimationController? animationController;

  @override
  void initState() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    animationController?.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        widget.onLongPress!();
      },
      child: Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(
              vertical: 14,
              horizontal: 14,
            ),
            child: AnimatedBuilder(
              animation: animationController!,
              builder: (BuildContext context, Widget? child) {
                return Transform(
                  transform: Matrix4.translationValues(0.0, 0.0, 0.0),
                  child: PhysicalShape(
                    color: Colors.transparent,
                    elevation: 0,
                    clipBehavior: Clip.antiAlias,
                    clipper: NavigationBarClipper(
                        radius: Tween(begin: 0.0, end: 1.0)
                                .animate(
                                  CurvedAnimation(
                                      parent: animationController!,
                                      curve: Curves.fastOutSlowIn),
                                )
                                .value *
                            38.0),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppTheme.nearlyWhite.withOpacity(0.1),
                          boxShadow: [
                            BoxShadow(
                              color: AppTheme.grey.withOpacity(0.1),
                              blurRadius: 6,
                              spreadRadius: 10,
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 62,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  left: 8,
                                  right: 8,
                                  top: 4,
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: NavigationBarIcons(
                                          navigationBarIcon: widget
                                              .navigationBarIcons?['diary'],
                                          removeAllSelect: () {
                                            setRemoveAllSelection(widget
                                                .navigationBarIcons?['diary']);
                                            widget.changeIndex!(0);
                                          }),
                                    ),
                                    Expanded(
                                      child: NavigationBarIcons(
                                          navigationBarIcon: widget
                                              .navigationBarIcons?['grocery'],
                                          removeAllSelect: () {
                                            setRemoveAllSelection(
                                                widget.navigationBarIcons?[
                                                    'grocery']);
                                            widget.changeIndex!(1);
                                          }),
                                    ),
                                    SizedBox(
                                      width: Tween(begin: 0.0, end: 1.0)
                                              .animate(CurvedAnimation(
                                                  parent: animationController!,
                                                  curve: Curves.fastOutSlowIn))
                                              .value *
                                          64.0,
                                    ),
                                    Expanded(
                                      child: NavigationBarIcons(
                                          navigationBarIcon:
                                              widget.navigationBarIcons?[
                                                  'notification'],
                                          removeAllSelect: () {
                                            setRemoveAllSelection(
                                                widget.navigationBarIcons?[
                                                    'notification']);
                                            widget.changeIndex!(3);
                                          }),
                                    ),
                                    Expanded(
                                      child: NavigationBarIcons(
                                          navigationBarIcon: widget
                                              .navigationBarIcons?['meal'],
                                          removeAllSelect: () {
                                            setRemoveAllSelection(widget
                                                .navigationBarIcons?['meal']);
                                            widget.changeIndex!(4);
                                          }),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).padding.bottom,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            margin: const EdgeInsets.only(
              bottom: 14,
            ),
            child: Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).padding.bottom,
              ),
              child: SizedBox(
                width: 38 * 2.0,
                height: 38 + 62.0,
                child: Container(
                  alignment: Alignment.topCenter,
                  color: Colors.transparent,
                  child: SizedBox(
                    width: 38 * 2.0,
                    height: 38 * 2.0,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ScaleTransition(
                        alignment: Alignment.center,
                        scale: Tween(begin: 0.0, end: 1.0).animate(
                          CurvedAnimation(
                            parent: animationController!,
                            curve: Curves.fastOutSlowIn,
                          ),
                        ),
                        child: Container(
                          // alignment: Alignment.center,s
                          decoration: BoxDecoration(
                            color: AppTheme.nearlyOrange,
                            gradient: LinearGradient(
                              colors: [
                                AppTheme.nearlyOrange,
                                HexColor('#FF9159'),
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            shape: BoxShape.circle,
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                color: AppTheme.nearlyOrange.withOpacity(0.4),
                                offset: const Offset(8.0, 16.0),
                                blurRadius: 16.0,
                              ),
                            ],
                          ),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              splashColor: Colors.white.withOpacity(0.1),
                              highlightColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              onTap: () {
                                widget.addClick!();
                                widget.changeIndex!(2);
                              },
                              child: const Icon(
                                Icons.kitchen,
                                color: AppTheme.white,
                                size: 32,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void setRemoveAllSelection(AppNavigationBarIcon? navigationBarIcon) {
    if (!mounted) return;

    setState(() {
      widget.navigationBarIcons?.forEach((key, AppNavigationBarIcon tab) {
        tab.isSelected = false;

        if (navigationBarIcon!.index == tab.index) {
          tab.isSelected = true;
        }
      });
    });
  }
}

class NavigationBarIcons extends StatefulWidget {
  const NavigationBarIcons(
      {Key? key, this.navigationBarIcon, this.removeAllSelect})
      : super(key: key);

  final AppNavigationBarIcon? navigationBarIcon;
  final Function()? removeAllSelect;

  @override
  _TabIconsState createState() => _TabIconsState();
}

class _TabIconsState extends State<NavigationBarIcons>
    with TickerProviderStateMixin {
  @override
  void initState() {
    widget.navigationBarIcon?.animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    )..addStatusListener((AnimationStatus status) {
        if (status == AnimationStatus.completed) {
          if (!mounted) return;
          widget.removeAllSelect!();
          widget.navigationBarIcon?.animationController?.reverse();
        }
      });
    super.initState();
  }

  void setAnimation() {
    widget.navigationBarIcon?.animationController?.forward();
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Center(
        child: InkWell(
          splashColor: Colors.transparent,
          focusColor: Colors.transparent,
          highlightColor: Colors.transparent,
          hoverColor: Colors.transparent,
          onTap: () {
            if (!widget.navigationBarIcon!.isSelected) {
              setAnimation();
            }
          },
          child: IgnorePointer(
            child: Stack(
              alignment: AlignmentDirectional.center,
              children: [
                ScaleTransition(
                  alignment: Alignment.center,
                  scale: Tween(begin: 0.88, end: 1.0).animate(
                    CurvedAnimation(
                      parent: widget.navigationBarIcon!.animationController!,
                      curve:
                          const Interval(0.1, 1.0, curve: Curves.fastOutSlowIn),
                    ),
                  ),
                  child: SvgPicture.asset(
                    widget.navigationBarIcon!.icon,
                    colorFilter: ColorFilter.mode(
                        widget.navigationBarIcon!.isSelected
                            ? AppTheme.nearlyTiger.withOpacity(0.5)
                            : AppTheme.deactivatedText,
                        BlendMode.srcIn),
                    height: 25,
                    width: 25,
                    fit: BoxFit.scaleDown,
                  ),
                ),
                if (widget.navigationBarIcon!.isSelected)
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: AppTheme.nearlyOrange.withOpacity(0.4),
                            blurRadius: 10,
                            spreadRadius: 8,
                          ),
                        ],
                      ),
                    ),
                  ),
                Positioned(
                  top: 4,
                  left: 6,
                  right: 0,
                  child: ScaleTransition(
                    alignment: Alignment.center,
                    scale: Tween(begin: 0.0, end: 1.0).animate(
                      CurvedAnimation(
                        parent: widget.navigationBarIcon!.animationController!,
                        curve: const Interval(0.2, 1.0,
                            curve: Curves.fastOutSlowIn),
                      ),
                    ),
                    child: Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        color: AppTheme.nearlyOrange,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 0,
                  left: 6,
                  bottom: 8,
                  child: ScaleTransition(
                    alignment: Alignment.center,
                    scale: Tween(begin: 0.0, end: 1.0).animate(
                      CurvedAnimation(
                        parent: widget.navigationBarIcon!.animationController!,
                        curve: const Interval(0.5, 0.8,
                            curve: Curves.fastOutSlowIn),
                      ),
                    ),
                    child: Container(
                      width: 4,
                      height: 4,
                      decoration: const BoxDecoration(
                        color: AppTheme.nearlyOrange,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 6,
                  right: 8,
                  bottom: 0,
                  child: ScaleTransition(
                    alignment: Alignment.center,
                    scale: Tween(begin: 0.0, end: 1.0).animate(
                      CurvedAnimation(
                        parent: widget.navigationBarIcon!.animationController!,
                        curve: const Interval(0.5, 0.6,
                            curve: Curves.fastOutSlowIn),
                      ),
                    ),
                    child: Container(
                      width: 6,
                      height: 6,
                      decoration: const BoxDecoration(
                        color: AppTheme.nearlyOrange,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class NavigationBarClipper extends CustomClipper<Path> {
  NavigationBarClipper({this.radius = 38.0});

  final double radius;

  @override
  Path getClip(Size size) {
    final Path path = Path();
    final double v = radius * 2;

    path.lineTo(0, 0);
    path.arcTo(
      Rect.fromLTWH(0, 0, radius, radius),
      degreeToRadians(180),
      degreeToRadians(90),
      false,
    );
    path.arcTo(
      Rect.fromLTWH(
          ((size.width / 2) - v / 2) - radius + v * 0.04, 0, radius, radius),
      degreeToRadians(270),
      degreeToRadians(70),
      false,
    );

    path.arcTo(
      Rect.fromLTWH((size.width / 2) - v / 2, -v / 2, v, v),
      degreeToRadians(160),
      degreeToRadians(-140),
      false,
    );

    path.arcTo(
        Rect.fromLTWH((size.width - ((size.width / 2) - v / 2)) - v * 0.04, 0,
            radius, radius),
        degreeToRadians(200),
        degreeToRadians(70),
        false);
    path.arcTo(
      Rect.fromLTWH(size.width - radius, 0, radius, radius),
      degreeToRadians(270),
      degreeToRadians(90),
      false,
    );

    // Bottom right corner
    path.arcTo(
      Rect.fromLTWH(size.width - radius, size.height - radius, radius, radius),
      degreeToRadians(0),
      degreeToRadians(90),
      false,
    );

    // Bottom side
    path.lineTo(radius, size.height);

    // Bottom left corner
    path.arcTo(
      Rect.fromLTWH(0, size.height - radius, radius, radius),
      degreeToRadians(90),
      degreeToRadians(90),
      false,
    );

    // path.lineTo(size.width, 0);
    // path.lineTo(size.width, size.height);
    // path.lineTo(0, size.height);

    path.close();

    return path;
  }

  @override
  bool shouldReclip(NavigationBarClipper oldClipper) => true;

  double degreeToRadians(double degree) {
    final double redian = (math.pi / 180) * degree;
    return redian;
  }
}
