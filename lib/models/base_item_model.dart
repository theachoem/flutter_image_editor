import 'package:flutter/material.dart';

abstract class BaseItemModel {
  final String label;
  final IconData iconData;

  BaseItemModel(this.label, this.iconData);
}
