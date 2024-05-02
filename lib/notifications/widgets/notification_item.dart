import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_fridge/src/config/themes/app_theme.dart';
import 'package:smart_fridge/src/features/notifications/data/notifications_list_data.dart';

class NotificationItem extends StatelessWidget {
  final VoidCallback? callback;
  final NotificationListData? data;
  final AnimationController? animationController;
  final Animation<double>? animation;

  const NotificationItem({
    super.key,
    this.data,
    this.animationController,
    this.animation,
    this.callback,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController!,
      builder: (BuildContext context, Widget? child) {
        return FadeTransition(
          opacity: animation!,
          child: Transform(
            transform: Matrix4.translationValues(
                0.0, 50 * (1.0 - animation!.value), 0.0),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 16,
              ),
              child: InkWell(
                splashColor: Colors.transparent,
                onTap: callback,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.0),
                      boxShadow: [
                        BoxShadow(
                          color: AppTheme.nearlyLighterBlue,
                          spreadRadius: 0,
                          blurRadius: 6,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(16.0)),
                      child: Stack(
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Container(
                                color:
                                    AppTheme.buildLightTheme().backgroundColor,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Expanded(
                                      child: Container(
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                            left: 16,
                                            top: 8,
                                            bottom: 8,
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              messageTitle(),
                                              messageContent(),
                                              timeSent(),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget timeSent() {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            data!.time,
            style: TextStyle(
              fontFamily: AppTheme.fontName,
              fontWeight: FontWeight.w500,
              fontSize: 12,
              letterSpacing: 0.5,
              color: AppTheme.grey.withOpacity(.6),
            ),
          ),
        ],
      ),
    );
  }

  Widget messageTitle() {
    return Text(
      data!.title,
      textAlign: TextAlign.left,
      style: TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 13,
        color: AppTheme.grey.withOpacity(.8),
      ),
    );
  }

  Widget messageContent() {
    return Text(
      data!.description,
      textAlign: TextAlign.left,
      style: TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 14,
      ),
      overflow: TextOverflow.ellipsis,
      maxLines: 2,
    );
  }
}
