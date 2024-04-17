import 'package:flutter/material.dart';
import 'package:smart_fridge/src/config/math/scaler.dart';
import 'package:smart_fridge/src/config/themes/app_theme.dart';
import 'package:smart_fridge/src/utils/date_picker.dart';

enum AppTopBarAction {
  none,
  datepicker,
  favourites,
  close,
}

class AppTopBar extends StatefulWidget {
  final String title;
  final AppTopBarAction action;
  final double topBarOpacity;
  final AnimationController? animationController;
  final Animation<double>? animation;

  const AppTopBar({
    super.key,
    this.action = AppTopBarAction.none,
    required this.topBarOpacity,
    required this.title,
    this.animationController,
    this.animation,
  });

  @override
  State<AppTopBar> createState() => _AppTopBarState();
}

class _AppTopBarState extends State<AppTopBar> with TickerProviderStateMixin {
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
                      bottomRight: Radius.circular(18.0),
                    ),
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
                                  textScaleFactor:
                                      Scaler.textScaleFactor(context),
                                ),
                              ),
                            ),
                            _getActionWidget(),
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

  Widget _getActionWidget() {
    switch (widget.action) {
      case AppTopBarAction.datepicker:
        return DatePicker(
          startDate: startDate,
          endDate: endDate,
          onDateChange: (DateTime start, DateTime end) {
            setState(() {
              startDate = start;
              endDate = end;
            });
          },
        );
      case AppTopBarAction.favourites:
        return InkWell(
          highlightColor: Colors.transparent,
          borderRadius: const BorderRadius.all(
            Radius.circular(32.0),
          ),
          onTap: () {},
          child: Icon(
            Icons.favorite_border_outlined,
            color: AppTheme.nearlyBlack,
          ),
        );
      case AppTopBarAction.close:
        return InkWell(
          highlightColor: Colors.transparent,
          borderRadius: const BorderRadius.all(
            Radius.circular(32.0),
          ),
          onTap: () => Navigator.pop(context),
          child: Icon(
            Icons.close,
            color: AppTheme.nearlyBlack,
          ),
        );
      case AppTopBarAction.none:
      default:
        return SizedBox(); // No action
    }
  }
}
