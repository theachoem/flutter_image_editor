import 'package:flutter/material.dart';
import 'package:flutter_image_editor/configs/theme_config.dart';
import 'package:hooks_riverpod/all.dart';

class ThemeNotifier extends ChangeNotifier {
  bool isDarkMode;

  ThemeNotifier() {
    isDarkMode = false;
  }

  toggleMode() {
    setMode(!isDarkMode);
  }

  void setMode(bool value) {
    if (value == isDarkMode) return;
    isDarkMode = value;
    notifyListeners();
  }

  void setDarkMode() {
    setMode(true);
  }

  void setLightMode() {
    setMode(false);
  }

  String get themeName {
    return isDarkMode ? 'Dark Mode' : 'Ligth Mode';
  }

  ThemeMode get themeMode {
    return isDarkMode ? ThemeMode.dark : ThemeMode.light;
  }

  ThemeData get themeData {
    return ThemeConfig(isDarkMode).get();
  }
}

final themeNotifier = ChangeNotifierProvider<ThemeNotifier>((ref) {
  var notifier = ThemeNotifier();
  return notifier;
});
