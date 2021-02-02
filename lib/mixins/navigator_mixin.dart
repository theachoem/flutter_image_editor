import 'package:flutter/material.dart';

mixin NavigatorMixin {
  void closeModal(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Navigator.of(context).pop();
    });
  }
}
