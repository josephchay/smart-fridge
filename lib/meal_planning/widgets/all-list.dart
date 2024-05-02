import 'package:flutter/material.dart';
import 'package:smart_fridge/meal_planning/models/meal.dart';
import 'package:smart_fridge/meal_planning/widgets/latest.dart';
import 'package:smart_fridge/config/themes/app_theme.dart';
import 'package:smart_fridge/top_bar.dart';

class AppMealPlannerAllList extends StatefulWidget {
  final String type;
  final List<Meal> data;
  final AnimationController? animationController;

  const AppMealPlannerAllList({
    super.key,
    required this.type,
    required this.data,
    this.animationController,
  });

  @override
  State<AppMealPlannerAllList> createState() => _AppMealPlannerAllListState();
}

class _AppMealPlannerAllListState extends State<AppMealPlannerAllList>
    with TickerProviderStateMixin {
  Animation<double>? topBarAnimation;

  double topBarOpacity = 0.0;

  AnimationController? animationController;
  ScrollController _scrollController = ScrollController();
  int _currentMaxItem = 20; // Start with some initial items

  @override
  void initState() {
    super.initState();

    topBarAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: widget.animationController!,
        curve: const Interval(0, 0.5, curve: Curves.fastOutSlowIn),
      ),
    );

    _scrollController.addListener(() {
      if (!mounted) return;

      if (_scrollController.offset >= 24) {
        if (topBarOpacity != 1.0) {
          setState(() {
            topBarOpacity = 1.0;
          });
        }
      } else if (_scrollController.offset <= 24 &&
          _scrollController.offset >= 0) {
        if (topBarOpacity != _scrollController.offset / 24) {
          setState(() {
            topBarOpacity = _scrollController.offset / 24;
          });
        }
      } else if (_scrollController.offset <= 0) {
        if (topBarOpacity != 0.0) {
          setState(() {
            topBarOpacity = 0.0;
          });
        }
      }
    });

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _getMoreData(); // Fetch more items when the end is reached
      }
    });
    animationController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );
  }

  void _getMoreData() {
    if (_currentMaxItem < widget.data.length) {
      // If there are more items to load
      setState(() {
        _currentMaxItem += 20;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.background,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: <Widget>[
            getGridViewUI(context),
            AppTopBar(
              title: widget.type,
              action: AppTopBarAction.close,
              topBarOpacity: topBarOpacity,
              animationController: widget.animationController,
              animation: topBarAnimation,
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: SizedBox(
                height: MediaQuery.of(context)
                    .padding
                    .bottom, // Padding for the bottom notch area
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getGridViewUI(BuildContext context) {
    return SingleChildScrollView(
      controller: _scrollController,
      child: Padding(
        padding: const EdgeInsets.only(
          left: 15,
          right: 15,
          top: 70,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 20,
                mainAxisSpacing: 50,
              ),
              itemCount: _currentMaxItem < widget.data.length
                  ? _currentMaxItem
                  : widget.data.length,
              itemBuilder: (BuildContext context, int index) {
                // Build animation for visible items
                final Animation<double> animation =
                    Tween<double>(begin: 0.0, end: 1.0).animate(
                  CurvedAnimation(
                    parent: animationController!,
                    curve: Interval(
                      (1 / _currentMaxItem) * index,
                      1.0,
                      curve: Curves.fastOutSlowIn,
                    ),
                  ),
                );
                animationController?.forward();

                // Display the meal card
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Wrap(
                    children: [
                      MealCard(
                        meal: widget.data[index],
                        animation: animation,
                        animationController: animationController,
                        textEllipsis: true,
                        textMaxLines: 1,
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    animationController?.dispose();
    super.dispose();
  }
}
