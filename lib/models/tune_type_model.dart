import 'package:flutter/material.dart';
import 'package:flutter_image_editor/models/base_item_model.dart';
import 'package:flutter_image_editor/types/tune_type.dart';

class TuneTypeModel extends BaseItemModel {
  TuneTypeModel({
    String label,
    IconData iconData,
    @required this.type,
  }) : super(label, iconData);

  final TuneType type;

  double _value, _valueAsPercent;
  double get value => this._value ?? 0;
  double get valueAsPercent => this._valueAsPercent ?? 0;

  setValue(double newValue) => this._value = newValue;
  setValueAsPercentage(double valueAsPercent) => this._valueAsPercent = valueAsPercent;

  static List<TuneTypeModel> get tuneTypesList {
    return [
      TuneTypeModel(label: "Brightness", type: TuneType.Brightness),
      TuneTypeModel(label: "Constrast", type: TuneType.Constrast),
      TuneTypeModel(label: "Saturation", type: TuneType.Saturation),
      TuneTypeModel(label: "Ambiance", type: TuneType.Ambiance),
      TuneTypeModel(label: "Highlights", type: TuneType.Highlights),
      TuneTypeModel(label: "Shadows", type: TuneType.Shadows),
      TuneTypeModel(label: "Warmth", type: TuneType.Warmth),
    ];
  }
}
