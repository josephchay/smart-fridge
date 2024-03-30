import 'package:flutter/material.dart';
import 'package:smart_fridge/src/config/themes/app_theme.dart';

import 'grocery_listings/calendar_popup_view.dart';

class AppClientTopBar extends StatefulWidget {
  const AppClientTopBar({
    super.key,
    required this.topBarOpacity,
    this.withDateModification = false,
    required this.title,
    this.animationController,
    this.animation,
  });

  final String title;
  final double topBarOpacity;
  final bool withDateModification;
  final AnimationController? animationController;
  final Animation<double>? animation;

  @override
  State<AppClientTopBar> createState() => _AppClientTopBarState();
}

class _AppClientTopBarState extends State<AppClientTopBar>
    with TickerProviderStateMixin {
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now().add(const Duration(days: 5));

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        AnimatedBuilder(
          animation: widget.animationController!,
          builder: (BuildContext context, Widget? child) {
            return FadeTransition(
              opacity: widget.animation!,
              child: Transform(
                transform: Matrix4.translationValues(
                    0.0, 30 * (1.0 - widget.animation!.value), 0.0),
                child: Container(
                  decoration: BoxDecoration(
                    color:
                        AppTheme.background.withOpacity(widget.topBarOpacity),
                    borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(18.0),
                        bottomRight: Radius.circular(18.0)),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: AppTheme.lightGrey
                            .withOpacity(0.2 * widget.topBarOpacity),
                        offset: const Offset(1.1, 1.1),
                        blurRadius: 8.0,
                        spreadRadius: 10.0,
                      ),
                    ],
                  ),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: MediaQuery.of(context).padding.top,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          left: 16,
                          right: 16,
                          top: 16 - 8.0 * widget.topBarOpacity,
                          bottom: 12 - 8.0 * widget.topBarOpacity,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  widget.title,
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 22 + 6 - 6 * widget.topBarOpacity,
                                    letterSpacing: 1.2,
                                    color: AppTheme.darkerText,
                                  ),
                                ),
                              ),
                            ),
                            if (widget.withDateModification) ...[
                              SizedBox(
                                height: 38,
                                width: 38,
                                child: InkWell(
                                  highlightColor: Colors.transparent,
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(32.0),
                                  ),
                                  onTap: () {},
                                  child: Center(
                                    child: Icon(
                                      Icons.keyboard_arrow_left,
                                      color: AppTheme.grey,
                                    ),
                                  ),
                                ),
                              ),
                              Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  focusColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  splashColor: Colors.grey.withOpacity(0.2),
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(4.0),
                                  ),
                                  onTap: () {
                                    FocusScope.of(context)
                                        .requestFocus(FocusNode());
                                    // setState(() {
                                    //   isDatePopupOpen = true;
                                    // });
                                    showDemoDialog(context: context);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                      left: 8,
                                      right: 8,
                                    ),
                                    child: Row(
                                      children: <Widget>[
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 8),
                                          child: Icon(
                                            Icons.calendar_today,
                                            color: AppTheme.grey,
                                            size: 18,
                                          ),
                                        ),
                                        Text(
                                          '15 May',
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            fontFamily: AppTheme.fontName,
                                            fontWeight: FontWeight.normal,
                                            fontSize: 18,
                                            letterSpacing: -0.2,
                                            color: AppTheme.darkerText,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 38,
                                width: 38,
                                child: InkWell(
                                  highlightColor: Colors.transparent,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(32.0)),
                                  onTap: () {},
                                  child: Center(
                                    child: Icon(
                                      Icons.keyboard_arrow_right,
                                      color: AppTheme.grey,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        )
      ],
    );
  }

  void showDemoDialog({BuildContext? context}) {
    showDialog<dynamic>(
      context: context!,
      builder: (BuildContext context) => CalendarPopupView(
        barrierDismissible: true,
        minimumDate: DateTime.now(),
        //  maximumDate: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day + 10),
        initialEndDate: endDate,
        initialStartDate: startDate,
        onApplyClick: (DateTime startData, DateTime endData) {
          setState(() {
            startDate = startData;
            endDate = endData;
          });
        },
        onCancelClick: () {},
      ),
    );
  }
}
