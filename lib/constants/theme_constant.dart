import 'package:flutter/material.dart';

class ThemeConstant {
  static const Color redPrimary = Color(0xFFd30e33);
  static const Color skyPrimary = Color(0xFF5284EC);
  static const Color greenPrimary = Color(0xFF60B357);

  static const Color darkPrimary = Color(0xFF323232);
  static const Color darkSecondary = Color(0xFF757575);
  static const Color greySecondary = Color(0xFFE0E0E0);
  static const Color backgroundLight = Color(0xFFFFFFFF);

  static Map<String, Color> dark = {
    'scaffoldBackgroundColor': darkPrimary,
    'appBarBackgroundColor': darkPrimary,
    'primaryColor': darkPrimary,
    'errorColor': redPrimary,
    'accentColor': skyPrimary,
    'canvasColor': greenPrimary,
    'iconColor': greySecondary,
    'headline': greySecondary,
    'bodyText': greySecondary,
    'subtitle': greySecondary,
    'buttonText': greySecondary,
    'caption': greySecondary,
    'overline': greySecondary,
    'dividerColor': darkSecondary,
    'hoverColor': backgroundLight.withOpacity(.05),
    "highlightColor": Colors.white.withOpacity(.05),
    "splashColor": Colors.transparent,
  };

  static Map<String, Color> light = {
    'scaffoldBackgroundColor': greySecondary,
    'appBarBackgroundColor': backgroundLight,
    'primaryColor': backgroundLight,
    'errorColor': redPrimary,
    'accentColor': skyPrimary,
    'canvasColor': greenPrimary,
    'iconColor': darkSecondary,
    'headline': darkPrimary,
    'bodyText': darkSecondary,
    'subtitle': darkSecondary,
    'buttonText': darkSecondary,
    'caption': darkSecondary,
    'overline': darkSecondary,
    'dividerColor': greySecondary.withOpacity(0.5),
    'hoverColor': darkPrimary.withOpacity(.05),
    "highlightColor": Colors.black.withOpacity(.05),
    "splashColor": Colors.transparent,
  };

  static Color color(String key, {bool isDarkMode = false}) {
    return isDarkMode ? dark[key] : light[key];
  }

  /// Text Theme - ref: https://material.io/design/typography/the-type-system.html
  /// Font weight - ref: https://www.npmjs.com/package/postcss-font-weight-names
  /// [100] Thin, Hairline
  /// [200] Extra Light, Ultra Light
  /// [300] Light
  /// [400] Normal, Regular
  /// [500] Medium
  /// [600] Semi Bold, Demi Bold
  /// [700] Bold
  /// [800] Extra Bold, Ultra Bold
  /// [900] Black, Heavy
  static TextTheme textTheme({bool isDarkMode = false}) {
    return TextTheme(
      headline1: TextStyle(
        fontSize: 96,
        letterSpacing: -1.5,
        fontWeight: FontWeight.w300,
        color: color("headline", isDarkMode: isDarkMode),
      ),
      headline2: TextStyle(
        fontSize: 60,
        letterSpacing: -0.5,

        ///default [w400]
        fontWeight: FontWeight.w300,
        color: color("headline", isDarkMode: isDarkMode),
      ),
      headline3: TextStyle(
        fontSize: 48,
        letterSpacing: 0,

        ///default [w400]
        fontWeight: FontWeight.w300,
        color: color("headline", isDarkMode: isDarkMode),
      ),
      headline4: TextStyle(
        fontSize: 34,
        letterSpacing: 0.25,

        ///default [w400]
        fontWeight: FontWeight.w300,
        color: color("headline", isDarkMode: isDarkMode),
      ),
      headline5: TextStyle(
        fontSize: 24,
        letterSpacing: 0,

        ///default [w400]
        fontWeight: FontWeight.w300,
        color: color("headline", isDarkMode: isDarkMode),
      ),
      headline6: TextStyle(
        fontSize: 20,
        letterSpacing: 0.15,

        ///default [w500]
        fontWeight: FontWeight.w400,
        color: color("headline", isDarkMode: isDarkMode),
      ),
      subtitle1: TextStyle(
        fontSize: 16,
        letterSpacing: 0.15,

        ///default [w500]
        fontWeight: FontWeight.w400,
        color: color("subtitle", isDarkMode: isDarkMode),
      ),
      subtitle2: TextStyle(
        fontSize: 14,
        letterSpacing: 0.1,

        ///default [w500]
        fontWeight: FontWeight.w400,
        color: color("subtitle", isDarkMode: isDarkMode),
      ),
      bodyText1: TextStyle(
        fontSize: 16,
        letterSpacing: 0.5,

        ///default [w400]
        fontWeight: FontWeight.w300,

        color: color("bodyText", isDarkMode: isDarkMode),
      ),
      bodyText2: TextStyle(
        fontSize: 14,
        letterSpacing: 0.25,

        ///default [w400]
        fontWeight: FontWeight.w300,
        color: color("bodyText", isDarkMode: isDarkMode),
      ),
      button: TextStyle(
        fontSize: 14,
        letterSpacing: 1.25,

        ///default [w400]
        fontWeight: FontWeight.w300,
        color: color("buttonText", isDarkMode: isDarkMode),
      ),
      caption: TextStyle(
        fontSize: 12,
        letterSpacing: 0.4,

        ///default [w400]
        fontWeight: FontWeight.w300,
        color: color("caption", isDarkMode: isDarkMode),
      ),
      overline: TextStyle(
        fontSize: 10,
        letterSpacing: 1.5,

        ///default [w400]
        fontWeight: FontWeight.w300,
        color: color("overline", isDarkMode: isDarkMode),
      ),
    ).apply(fontFamily: "Quicksand");
  }
}
