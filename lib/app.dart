import 'package:flutter/material.dart';
import 'package:flutter_image_editor/homepage.dart';
import 'package:flutter_image_editor/notifiers/theme_notifier.dart';
import 'package:hooks_riverpod/all.dart';

class App extends ConsumerWidget {
  @override
  Widget build(BuildContext context, reader) {
    final notifier = reader(themeNotifier);
    return MaterialApp(
      title: 'Flutter Image Editor',
      home: MyHomePage(title: 'Flutter App Example'),
      themeMode: notifier.themeMode,
      theme: notifier.themeData,
    );
  }
}
