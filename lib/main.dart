import 'package:flutter/material.dart';
import 'package:flutter_image_editor/app.dart';
import 'package:hooks_riverpod/all.dart';

void main() {
  runApp(
    ProviderScope(
      child: App(),
    ),
  );
}
