import 'package:flutter/material.dart';
import 'package:flutter_image_editor/notifiers/image_info.dart';
import 'package:flutter_image_editor/notifiers/theme_notifier.dart';
import 'package:flutter_image_editor/screens/tools/tune_image_screen.dart';
import 'package:flutter_image_editor/screens/editing_screen.dart';
import 'package:flutter_image_editor/screens/home_screen.dart';
import 'package:hooks_riverpod/all.dart';

class App extends ConsumerWidget {
  @override
  Widget build(BuildContext context, reader) {
    final notifier = reader(themeNotifier);
    return MaterialApp(
      title: 'Flutter Image Editor',
      initialRoute: '/home',
      routes: {
        '/home': (context) => HomeScreen(),
        '/editing': (context) => EditingScreen(),
        '/image_info': (context) => FieImageInfo(),
        '/tune_image': (context) => TuneImageScreen(),
      },
      themeMode: notifier.themeMode,
      theme: notifier.themeData,
    );
  }
}
