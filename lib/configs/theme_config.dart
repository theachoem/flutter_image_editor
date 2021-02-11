import 'package:flutter/material.dart';
import 'package:flutter_image_editor/constants/theme_constant.dart';

class ThemeConfig {
  bool isDarkMode;
  ThemeConfig(this.isDarkMode);

  Color color(String key) {
    return ThemeConstant.color(key, isDarkMode: this.isDarkMode);
  }

  ThemeData get() {
    var theme = this.isDarkMode ? ThemeData.dark() : ThemeData.light();
    return theme.copyWith(
      scaffoldBackgroundColor: scaffoldBackgroundColor,
      backgroundColor: backgroundColor,
      highlightColor: highlightColor,
      primaryColor: primaryColor,
      accentColor: accentColor,
      splashColor: splashColor,
      canvasColor: canvasColor,
      errorColor: errorColor,
      hoverColor: hoverColor,
      textTheme: textTheme,
      iconTheme: iconTheme,
      buttonTheme: buttonTheme,
      appBarTheme: appBarTheme,
      dividerTheme: dividerTheme,
      toggleButtonsTheme: toggleButtonsTheme,
      pageTransitionsTheme: pageTransitionsTheme,
      bottomNavigationBarTheme: bottomNavigationBarTheme,
    );
  }

  Color get scaffoldBackgroundColor => color("scaffoldBackgroundColor");
  Color get appBarBackgroundColor => color("appBarBackgroundColor");
  Color get backgroundColor => color("backgroundColor");
  Color get highlightColor => color("highlightColor");
  Color get primaryColor => color("primaryColor");
  Color get accentColor => color("accentColor");
  Color get splashColor => color("splashColor");
  Color get canvasColor => color("canvasColor");
  Color get errorColor => color("errorColor");
  Color get hoverColor => color("hoverColor");
  Color get iconColor => color("iconColor");
  Color get dividerColor => color("dividerColor");

  TextTheme get textTheme {
    return ThemeConstant.textTheme(isDarkMode: this.isDarkMode);
  }

  AppBarTheme get appBarTheme {
    return AppBarTheme(
      textTheme: textTheme,
      color: appBarBackgroundColor,
      iconTheme: IconThemeData(
        color: iconColor,
      ),
    );
  }

  ButtonThemeData get buttonTheme {
    return ButtonThemeData(
      hoverColor: hoverColor,
      highlightColor: highlightColor,
      splashColor: splashColor,
    );
  }

  ToggleButtonsThemeData get toggleButtonsTheme {
    return ToggleButtonsThemeData(
      hoverColor: hoverColor,
      highlightColor: highlightColor,
      splashColor: splashColor,
    );
  }

  BottomNavigationBarThemeData get bottomNavigationBarTheme {
    return BottomNavigationBarThemeData(
      showSelectedLabels: false,
      showUnselectedLabels: false,
      type: BottomNavigationBarType.fixed,
      backgroundColor: primaryColor,
      selectedItemColor: accentColor,
    );
  }

  IconThemeData get iconTheme {
    return IconThemeData(
      color: iconColor,
    );
  }

  DividerThemeData get dividerTheme {
    return DividerThemeData(
      indent: 8,
      endIndent: 8,
      thickness: 0.5,
      color: dividerColor,
    );
  }

  // change default android page transition to ios (optional)
  PageTransitionsTheme get pageTransitionsTheme {
    return const PageTransitionsTheme(
      builders: <TargetPlatform, PageTransitionsBuilder>{
        TargetPlatform.android: CupertinoPageTransitionsBuilder(),
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      },
    );
  }
}
