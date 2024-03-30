import 'package:flutter/material.dart';

import '../../../core/util/color.dart';

class AppTheme {
  AppTheme._();

  static const Color nearlyWhite = Color(0xFFFAFAFA);
  static const Color white = Color(0xFFFFFFFF);
  static const Color background = Color(0xFFF2F3F8);
  static const Color nearlyOrange = Color(0xFFFDCD4B);
  static const Color nearlyDarkOrange = Color(0xFFFFBB4F);
  static const Color nearlyTiger = Color(0xFFFE724D);

  static const Color nearlyDarkBlue = Color(0xFF2633C5);
  static const Color nearlyBlue = Color(0xFF00B6F0);
  static const Color nearlyLightBlue = Color(0xFFBCC8FF);
  static const Color nearlyLighterBlue = Color(0xFFDCE0EC);
  static const Color nearlyBlack = Color(0xFF0A0B0B);
  static const Color lighterGrey = Color(0xFFABABA9);
  static const Color lightGrey = Color(0xFF666561);
  static const Color grey = Color(0xFF48453C);
  static const Color darkGrey = Color(0xFF37352F);

  static const Color darkText = Color(0xFF272D2F);
  static const Color darkerText = Color(0xFF1A1C1D);
  static const Color lightText = Color(0xFF4A6572);
  static const Color lighterText = Color(0xFF57646B);
  static const Color deactivatedText = Color(0xFF767676);
  static const Color dismissibleBackground = Color(0xFF364A54);
  static const Color spacer = Color(0xFFF2F2F2);

  static const String fontName = 'WorkSans';

  static const TextTheme textTheme = TextTheme(
    headlineMedium: display1,
    headlineSmall: headline,
    titleLarge: title,
    titleSmall: subtitle,
    bodyMedium: body2,
    bodyLarge: body1,
    bodySmall: caption,
  );

  static const TextStyle display1 = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.bold,
    fontSize: 36,
    letterSpacing: 0.4,
    height: 1.5,
    color: darkerText,
  );

  static const TextStyle display2 = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.bold,
    fontSize: 30,
    letterSpacing: 0.4,
    height: 1.5,
    color: darkerText,
  );

  static const TextStyle headline = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.bold,
    fontSize: 24,
    letterSpacing: 0.27,
    color: darkerText,
  );

  static const TextStyle title = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.bold,
    fontSize: 16,
    letterSpacing: 0.18,
    color: darkerText,
  );

  static const TextStyle subtitle = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.w400,
    fontSize: 14,
    letterSpacing: -0.04,
    color: darkText,
  );

  static const TextStyle body1 = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.w400,
    fontSize: 16,
    letterSpacing: -0.05,
    color: darkText,
  );

  static const TextStyle body2 = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.w400,
    fontSize: 14,
    letterSpacing: 0.2,
    color: darkText,
  );

  static const TextStyle caption = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.w400,
    fontSize: 12,
    letterSpacing: 0.2,
    color: lightText,
  );

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    primarySwatch: Colors.blue,
    textTheme: AppTheme.textTheme,
    fontFamily: "WorkSans",
    // platform: TargetPlatform.iOS,
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    primarySwatch: Colors.blue,
    textTheme: AppTheme.textTheme,
    fontFamily: "WorkSans",
    // platform: TargetPlatform.iOS,
  );

  static TextTheme _buildTextTheme(TextTheme base) {
    const String fontName = 'WorkSans';
    return base.copyWith(
      headline1: base.headline1?.copyWith(fontFamily: fontName),
      headline2: base.headline2?.copyWith(fontFamily: fontName),
      headline3: base.headline3?.copyWith(fontFamily: fontName),
      headline4: base.headline4?.copyWith(fontFamily: fontName),
      headline5: base.headline5?.copyWith(fontFamily: fontName),
      headline6: base.headline6?.copyWith(fontFamily: fontName),
      button: base.button?.copyWith(fontFamily: fontName),
      caption: base.caption?.copyWith(fontFamily: fontName),
      bodyText1: base.bodyText1?.copyWith(fontFamily: fontName),
      bodyText2: base.bodyText2?.copyWith(fontFamily: fontName),
      subtitle1: base.subtitle1?.copyWith(fontFamily: fontName),
      subtitle2: base.subtitle2?.copyWith(fontFamily: fontName),
      overline: base.overline?.copyWith(fontFamily: fontName),
    );
  }

  static ThemeData buildLightTheme() {
    final Color primaryColor = HexColor('#FFFDCD4B');
    final Color secondaryColor = HexColor('#FFFFBB4F');
    final ColorScheme colorScheme = const ColorScheme.light().copyWith(
      primary: primaryColor,
      secondary: secondaryColor,
    );
    final ThemeData base = ThemeData.light();
    return base.copyWith(
      colorScheme: colorScheme,
      primaryColor: primaryColor,
      indicatorColor: Colors.white,
      splashColor: Colors.white24,
      splashFactory: InkRipple.splashFactory,
      canvasColor: Colors.white,
      backgroundColor: const Color(0xFFFFFFFF),
      scaffoldBackgroundColor: const Color(0xFFF6F6F6),
      errorColor: const Color(0xFFB00020),
      buttonTheme: ButtonThemeData(
        colorScheme: colorScheme,
        textTheme: ButtonTextTheme.primary,
      ),
      textTheme: _buildTextTheme(base.textTheme),
      primaryTextTheme: _buildTextTheme(base.primaryTextTheme),
      platform: TargetPlatform.iOS,
    );
  }
}
