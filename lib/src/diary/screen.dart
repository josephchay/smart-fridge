import 'package:flutter/material.dart';
import 'package:smart_fridge/src/config/themes/app_theme.dart';
import 'package:smart_fridge/src/diary/current_diets_list_view.dart';
import 'package:smart_fridge/src/ui_view/accumulated_nutrition_view.dart';
import 'package:smart_fridge/src/ui_view/body_measurement.dart';
import 'package:smart_fridge/src/ui_view/title_view.dart';

import '../../top_bar.dart';

/// The Home (first) Page of the app
class AppDiaryScreen extends StatefulWidget {
  final AnimationController? animationController;
  final Function(double) onScroll;

  const AppDiaryScreen({
    Key? key,
    this.animationController,
    required this.onScroll,
  }) : super(key: key);

  @override
  _AppDiaryScreenState createState() => _AppDiaryScreenState();
}

class _AppDiaryScreenState extends State<AppDiaryScreen>
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

      widget.onScroll(scrollController.offset);
    });
    super.initState();
  }

  void addAllListData() {
    const int count = 9;

    listViews.add(
      TitleView(
        titleTxt: 'Accumulated Nutrition',
        subTxt: 'Details',
        animation: Tween<double>(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(
            parent: widget.animationController!,
            curve: Interval((1 / count) * 0, 1.0, curve: Curves.fastOutSlowIn),
          ),
        ),
        animationController: widget.animationController!,
      ),
    );
    listViews.add(
      AppAccumulatedNutritionView(
        animation: Tween<double>(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(
            parent: widget.animationController!,
            curve: Interval((1 / count) * 1, 1.0, curve: Curves.fastOutSlowIn),
          ),
        ),
        animationController: widget.animationController!,
      ),
    );
    listViews.add(
      TitleView(
        titleTxt: 'Current Diet',
        subTxt: 'Details',
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
      CurrentDietsListView(
        mainScreenAnimation: Tween<double>(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(
            parent: widget.animationController!,
            curve: Interval((1 / count) * 3, 1.0, curve: Curves.fastOutSlowIn),
          ),
        ),
        mainScreenAnimationController: widget.animationController,
      ),
    );

    listViews.add(
      TitleView(
        titleTxt: 'Body measurement',
        subTxt: 'Details',
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
      BodyMeasurementView(
        animation: Tween<double>(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(
            parent: widget.animationController!,
            curve: Interval((1 / count) * 5, 1.0, curve: Curves.fastOutSlowIn),
          ),
        ),
        animationController: widget.animationController!,
      ),
    );
    // listViews.add(
    //   TitleView(
    //     titleTxt: 'Water',
    //     subTxt: 'Aqua SmartBottle',
    //     animation: Tween<double>(begin: 0.0, end: 1.0).animate(
    //       CurvedAnimation(
    //         parent: widget.animationController!,
    //         curve: Interval((1 / count) * 6, 1.0, curve: Curves.fastOutSlowIn),
    //       ),
    //     ),
    //     animationController: widget.animationController!,
    //   ),
    // );
    //
    // listViews.add(
    //   WaterView(
    //     mainScreenAnimation: Tween<double>(begin: 0.0, end: 1.0).animate(
    //       CurvedAnimation(
    //         parent: widget.animationController!,
    //         curve: Interval((1 / count) * 7, 1.0, curve: Curves.fastOutSlowIn),
    //       ),
    //     ),
    //     mainScreenAnimationController: widget.animationController!,
    //   ),
    // );
    // listViews.add(
    //   GlassView(
    //       animation: Tween<double>(begin: 0.0, end: 1.0).animate(
    //         CurvedAnimation(
    //           parent: widget.animationController!,
    //           curve:
    //               Interval((1 / count) * 8, 1.0, curve: Curves.fastOutSlowIn),
    //         ),
    //       ),
    //       animationController: widget.animationController!),
    // );
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
              title: 'Diary',
              topBarOpacity: topBarOpacity,
              animationController: widget.animationController,
              animation: topBarAnimation,
              withDateModification: true,
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
