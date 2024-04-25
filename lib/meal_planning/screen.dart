import 'package:flutter/material.dart';
import 'package:smart_fridge/meal_planning/models/meal.dart';
import 'package:smart_fridge/meal_planning/widgets/categories.dart';
import 'package:smart_fridge/meal_planning/widgets/all-list.dart';
import 'package:smart_fridge/meal_planning/widgets/recommendations.dart';
import 'package:smart_fridge/meal_planning/widgets/search_bar.dart';
import 'package:smart_fridge/meal_planning/widgets/latest.dart';
import 'package:smart_fridge/src/config/themes/app_theme.dart';
import 'package:smart_fridge/src/ui_view/title_view.dart';
import 'package:smart_fridge/top_bar.dart';

class AppMealPlannerScreen extends StatefulWidget {
  final AnimationController? animationController;
  final ScrollController scrollController;

  const AppMealPlannerScreen({
    super.key,
    this.animationController,
    required this.scrollController,
  });

  @override
  _AppMealPlannerScreenState createState() => _AppMealPlannerScreenState();
}

class _AppMealPlannerScreenState extends State<AppMealPlannerScreen>
    with TickerProviderStateMixin {
  Animation<double>? topBarAnimation;

  List<Widget> listViews = <Widget>[];
  double topBarOpacity = 0.0;

  List<Meal> allMeals = [];
  List<Meal> filteredLatestMeals = [];
  List<Meal> filteredRecommendedMeals = [];

  @override
  void initState() {
    super.initState();
    filteredLatestMeals = List.from(latestMealList);
    filteredRecommendedMeals = List.from(recommendedMealList);

    topBarAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: widget.animationController!,
        curve: const Interval(0, 0.5, curve: Curves.fastOutSlowIn),
      ),
    );

    widget.scrollController.addListener(() {
      if (!mounted) return;

      if (widget.scrollController.offset >= 24) {
        if (topBarOpacity != 1.0) {
          setState(() {
            topBarOpacity = 1.0;
          });
        }
      } else if (widget.scrollController.offset <= 24 &&
          widget.scrollController.offset >= 0) {
        if (topBarOpacity != widget.scrollController.offset / 24) {
          setState(() {
            topBarOpacity = widget.scrollController.offset / 24;
          });
        }
      } else if (widget.scrollController.offset <= 0) {
        if (topBarOpacity != 0.0) {
          setState(() {
            topBarOpacity = 0.0;
          });
        }
      }
    });

    addAllListData();
  }

  void onSearchChanged(String query) {
    setState(() {
      filteredLatestMeals = query.isEmpty
          ? List.from(latestMealList)
          : latestMealList
              .where((meal) =>
                  meal.name.toLowerCase().contains(query.toLowerCase()))
              .toList();
      filteredRecommendedMeals = query.isEmpty
          ? List.from(recommendedMealList)
          : recommendedMealList
              .where((meal) =>
                  meal.name.toLowerCase().contains(query.toLowerCase()))
              .toList();
      listViews.clear();
      addAllListData(); // Refresh the UI with the new lists
    });
  }

  void addAllListData() {
    const int count = 7; // number of items in the list

    listViews.add(
      AppPageSearchBar(
        animation: Tween<double>(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(
            parent: widget.animationController!,
            curve: Interval((1 / count) * 0, 1.0, curve: Curves.fastOutSlowIn),
          ),
        ),
        animationController: widget.animationController,
        onSearchChanged: onSearchChanged,
      ),
    );

    listViews.add(
      TitleView(
        titleTxt: 'Categories',
        hasBottomPadding: false,
        animation: Tween<double>(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(
            parent: widget.animationController!,
            curve: Interval((1 / count) * 1, 1.0, curve: Curves.fastOutSlowIn),
          ),
        ),
        animationController: widget.animationController,
      ),
    );

    listViews.add(
      AppMealPlannerFoodCategories(
        current: 'All',
        animation: Tween<double>(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(
            parent: widget.animationController!,
            curve: Interval((1 / count) * 2, 1.0, curve: Curves.fastOutSlowIn),
          ),
        ),
        animationController: widget.animationController,
      ),
    );

    listViews.add(
      TitleView(
        titleTxt: 'Recommendations',
        subTxt: 'View All',
        subTxtAction: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => AppMealPlannerAllList(
                    type: 'Recommendations',
                    data: recommendedMealList,
                    animationController: widget.animationController!,
                  )),
        ),
        hasBottomPadding: false,
        animation: Tween<double>(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(
            parent: widget.animationController!,
            curve: Interval((1 / count) * 3, 1.0, curve: Curves.fastOutSlowIn),
          ),
        ),
        animationController: widget.animationController,
      ),
    );

    listViews.add(
      AppMealPlannerRecommendations(
        animation: Tween<double>(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(
            parent: widget.animationController!,
            curve: Interval((1 / count) * 4, 1.0, curve: Curves.fastOutSlowIn),
          ),
        ),
        animationController: widget.animationController,
        meals: filteredRecommendedMeals,
      ),
    );

    listViews.add(
      TitleView(
        titleTxt: 'Latest',
        subTxt: 'View All',
        subTxtAction: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => AppMealPlannerAllList(
                    type: 'Latest',
                    data: latestMealList,
                    animationController: widget.animationController!,
                  )),
        ),
        animation: Tween<double>(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(
            parent: widget.animationController!,
            curve: Interval((1 / count) * 5, 1.0, curve: Curves.fastOutSlowIn),
          ),
        ),
        animationController: widget.animationController,
      ),
    );

    listViews.add(
      AppMealPlannerLatest(
        animation: Tween<double>(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(
            parent: widget.animationController!,
            curve: Interval((1 / count) * 6, 1.0, curve: Curves.fastOutSlowIn),
          ),
        ),
        animationController: widget.animationController,
        meals: filteredLatestMeals,
      ),
    );
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 50));
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.background,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: <Widget>[
            getListViewUI(),
            AppTopBar(
              title: 'Meals',
              action: AppTopBarAction.favourites,
              topBarOpacity: topBarOpacity,
              animationController: widget.animationController,
              animation: topBarAnimation,
            ),
            SizedBox(
              height: MediaQuery.of(context).padding.bottom,
            )
          ],
        ),
      ),
    );
  }

  Widget getListViewUI() {
    return FutureBuilder<bool>(
      future: getData(),
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        if (!snapshot.hasData) {
          return const SizedBox();
        } else {
          return ListView.builder(
            controller: widget.scrollController,
            padding: EdgeInsets.only(
              top: AppBar().preferredSize.height +
                  MediaQuery.of(context).padding.top +
                  24,
              bottom: 62 + MediaQuery.of(context).padding.bottom,
            ),
            itemCount: listViews.length,
            scrollDirection: Axis.vertical,
            itemBuilder: (BuildContext context, int index) {
              widget.animationController?.forward();
              return listViews[index];
            },
          );
        }
      },
    );
  }
}
