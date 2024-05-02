import 'package:flutter/material.dart';
import 'package:smart_fridge/src/features/notifications/data/notifications_list_model.dart';
import 'package:smart_fridge/src/features/notifications/presentation/notification_item.dart';

class NotificationListView extends StatefulWidget {
  final List<NotificationListData> data;
  final AnimationController? mainScreenAnimationController;
  final Animation<double>? mainScreenAnimation;

  const NotificationListView({
    super.key,
    required this.data,
    this.mainScreenAnimationController,
    this.mainScreenAnimation,
  });

  @override
  _NotificationListViewState createState() => _NotificationListViewState();
}

class _NotificationListViewState extends State<NotificationListView>
    with TickerProviderStateMixin {
  AnimationController? animationController;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    return true;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.mainScreenAnimationController!,
      builder: (BuildContext context, Widget? child) {
        return FadeTransition(
          opacity: widget.mainScreenAnimation!,
          child: Transform(
            transform: Matrix4.translationValues(
                0.0, 30 * (1.0 - widget.mainScreenAnimation!.value), 0.0),
            child: Container(
              height: 240,
              width: double.infinity,
              child: ListView.builder(
                padding: const EdgeInsets.only(
                  top: 0,
                  bottom: 0,
                  right: 16,
                  left: 16,
                ),
                itemCount: widget.data.length,
                itemBuilder: (BuildContext context, int index) {
                  final int count =
                      widget.data.length > 10 ? 10 : widget.data.length;
                  final Animation<double> animation =
                      Tween<double>(begin: 0.0, end: 1.0).animate(
                          CurvedAnimation(
                              parent: animationController!,
                              curve: Interval((1 / count) * index, 1.0,
                                  curve: Curves.fastOutSlowIn)));
                  animationController?.forward();

                  return NotificationItem(
                    callback: () {},
                    data: widget.data[index],
                    animation: animation,
                    animationController: animationController!,
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }

  // Widget getListUI() {
  //   return Expanded(
  //     child: Container(
  //       height: MediaQuery.of(context).size.height - 156 - 50,
  //       child: FutureBuilder<bool>(
  //         future: getData(),
  //         builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
  //           if (!snapshot.hasData) {
  //             return const SizedBox();
  //           } else {
  //             return ListView.builder(
  //               itemCount: widget.data.length,
  //               scrollDirection: Axis.vertical,
  //               itemBuilder: (BuildContext context, int index) {
  //                 final int count =
  //                     widget.data.length > 10 ? 10 : widget.data.length;
  //                 final Animation<double> animation =
  //                     Tween<double>(begin: 0.0, end: 1.0).animate(
  //                         CurvedAnimation(
  //                             parent: widget.mainScreenAnimationController!,
  //                             curve: Interval((1 / count) * index, 1.0,
  //                                 curve: Curves.fastOutSlowIn)));
  //                 widget.mainScreenAnimationController?.forward();
  //
  //                 return NotificationItem(
  //                   callback: () {},
  //                   data: widget.data[index],
  //                   animation: animation,
  //                   animationController: widget.mainScreenAnimationController!,
  //                 );
  //               },
  //             );
  //           }
  //         },
  //       ),
  //     ),
  //   );
  // }

  // Widget getNotificationViewList() {
  //   final List<Widget> NotificationListViews = <Widget>[];
  //   for (int i = 0; i < widget.data.length; i++) {
  //     final int count = widget.data.length;
  //     final Animation<double> animation =
  //         Tween<double>(begin: 0.0, end: 1.0).animate(
  //       CurvedAnimation(
  //         parent: widget.animationController!,
  //         curve: Interval((1 / count) * i, 1.0, curve: Curves.fastOutSlowIn),
  //       ),
  //     );
  //     NotificationListViews.add(
  //       NotificationItem(
  //         callback: () {},
  //         data: widget.data[i],
  //         animation: animation,
  //         animationController: widget.animationController!,
  //       ),
  //     );
  //   }
  //   widget.animationController?.forward();
  //   return Column(
  //     children: NotificationListViews,
  //   );
  // }
}
