import 'package:flutter/material.dart';
import 'package:smart_fridge/src/config/math/scaler.dart';
import 'package:smart_fridge/src/config/themes/app_theme.dart';

class TitleView extends StatelessWidget {
  final String titleTxt;
  final String subTxt;
  final bool hasTopPadding;
  final bool hasBottomPadding;
  final AnimationController? animationController;
  final Animation<double>? animation;

  const TitleView({
    super.key,
    this.titleTxt = "",
    this.subTxt = "",
    this.hasTopPadding = true,
    this.hasBottomPadding = true,
    this.animationController,
    this.animation,
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
                0.0, 30 * (1.0 - animation!.value), 0.0),
            child: Container(
              child: Padding(
                padding: EdgeInsets.only(
                  left: 24,
                  right: 24,
                  top: hasTopPadding ? 16 : 0,
                  bottom: hasBottomPadding ? 16 : 0,
                ),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        titleTxt,
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                          fontFamily: AppTheme.fontName,
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                          letterSpacing: 0.5,
                          color: AppTheme.lightText,
                        ),
                        textScaleFactor: Scaler.textScaleFactor(context),
                      ),
                    ),
                    InkWell(
                      highlightColor: Colors.transparent,
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10.0)),
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: <Widget>[
                            Text(
                              subTxt,
                              textAlign: TextAlign.left,
                              style: const TextStyle(
                                fontFamily: AppTheme.fontName,
                                fontWeight: FontWeight.normal,
                                fontSize: 14,
                                letterSpacing: 0.5,
                                color: AppTheme.nearlyDarkOrange,
                              ),
                              textScaleFactor: Scaler.textScaleFactor(context),
                            ),
                            // SizedBox(
                            //   height: 38,
                            //   width: 26,
                            //   child: Icon(
                            //     Icons.arrow_forward,
                            //     color: AppTheme.nearlyDarkOrange,
                            //     size: 18,
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
