import 'package:flutter/material.dart';
import 'package:flutter_image_editor/notifiers/theme_notifier.dart';
import 'package:flutter_image_editor/screens/home_screen.dart';
import 'package:hooks_riverpod/all.dart';

class App extends ConsumerWidget {
  @override
  Widget build(BuildContext context, reader) {
    final notifier = reader(themeNotifier);
    return MaterialApp(
      title: 'Flutter Image Editor',
      home: HomeScreen(),
      themeMode: notifier.themeMode,
      theme: notifier.themeData,
    );
  }
}
