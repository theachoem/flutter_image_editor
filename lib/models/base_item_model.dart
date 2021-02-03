import 'package:flutter/material.dart';

abstract class BaseItemModel {
  final String label;
  final String routeName;
  final IconData iconData;

  BaseItemModel(this.label, this.iconData, {this.routeName});
}
