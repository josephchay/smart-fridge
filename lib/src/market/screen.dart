import 'package:flutter/material.dart';
import 'package:smart_fridge/src/ui_view/food_category_view.dart';
import 'package:smart_fridge/src/ui_view/title_view.dart';

import '../../top_bar.dart';
import '../config/themes/app_theme.dart';
import '../ui_view/area_list_view.dart';
import '../ui_view/running_view.dart';
import '../ui_view/workout_view.dart';

class AppMarketScreen extends StatefulWidget {
  const AppMarketScreen({
    super.key,
    this.animationController,
  });

  final AnimationController? animationController;
  @override
  _AppMarketScreenState createState() => _AppMarketScreenState();
}

class _AppMarketScreenState extends State<AppMarketScreen>
    with TickerProviderStateMixin {
  Animation<double>? topBarAnimation;

  List<Widget> listViews = <Widget>[];
  final ScrollController scrollController = ScrollController();
  double topBarOpacity = 0.0;

  @override
  void initState() {
    topBarAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: widget.animationController!,
        curve: const Interval(0, 0.5, curve: Curves.fastOutSlowIn),
      ),
    );

    addAllListData();

    scrollController.addListener(() {
      if (scrollController.offset >= 24) {
        if (topBarOpacity != 1.0) {
          setState(() {
            topBarOpacity = 1.0;
          });
        }
      } else if (scrollController.offset <= 24 &&
          scrollController.offset >= 0) {
        if (topBarOpacity != scrollController.offset / 24) {
          setState(() {
            topBarOpacity = scrollController.offset / 24;
          });
        }
      } else if (scrollController.offset <= 0) {
        if (topBarOpacity != 0.0) {
          setState(() {
            topBarOpacity = 0.0;
          });
        }
      }
    });
    super.initState();
  }

  void addAllListData() {
    const int count = 5;

    listViews.add(
      TitleView(
        titleTxt: 'Food Categories',
        animation: Tween<double>(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(
            parent: widget.animationController!,
            curve: const Interval((1 / count) * 0, 1.0,
                curve: Curves.fastOutSlowIn),
          ),
        ),
        animationController: widget.animationController!,
      ),
    );

    listViews.add(
      FoodCategoryView(
        animation: Tween<double>(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(
            parent: widget.animationController!,
            curve: const Interval((1 / count) * 2, 1.0,
                curve: Curves.fastOutSlowIn),
          ),
        ),
        animationController: widget.animationController!,
      ),
    );

    listViews.add(
      WorkoutView(
        animation: Tween<double>(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(
            parent: widget.animationController!,
            curve: Interval((1 / count) * 2, 1.0, curve: Curves.fastOutSlowIn),
          ),
        ),
        animationController: widget.animationController!,
      ),
    );
    listViews.add(
      RunningView(
        animation: Tween<double>(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(
            parent: widget.animationController!,
            curve: Interval((1 / count) * 3, 1.0, curve: Curves.fastOutSlowIn),
          ),
        ),
        animationController: widget.animationController!,
      ),
    );

    listViews.add(
      TitleView(
        titleTxt: 'Area of focus',
        subTxt: 'more',
        animation: Tween<double>(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(
            parent: widget.animationController!,
            curve: Interval((1 / count) * 4, 1.0, curve: Curves.fastOutSlowIn),
          ),
        ),
        animationController: widget.animationController!,
      ),
    );

    listViews.add(
      AreaListView(
        mainScreenAnimation: Tween<double>(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(
            parent: widget.animationController!,
            curve: Interval((1 / count) * 5, 1.0, curve: Curves.fastOutSlowIn),
          ),
        ),
        mainScreenAnimationController: widget.animationController!,
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
            getMainListViewUI(),
            AppClientTopBar(
              title: 'Market',
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

  Widget getMainListViewUI() {
    return FutureBuilder<bool>(
      future: getData(),
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        if (!snapshot.hasData) {
          return const SizedBox();
        } else {
          return ListView.builder(
            controller: scrollController,
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
