import 'package:flutter/material.dart';
import 'package:flutter_image_editor/models/base_item_model.dart';
import 'package:flutter_image_editor/types/tools_type.dart';

class ToolsItemModel extends BaseItemModel {
  final ToolsType type;

  ToolsItemModel({
    @required this.type,
    String label,
    IconData iconData,
  }) : super(label, iconData);

  static List<ToolsItemModel> get tools {
    return [
      ToolsItemModel(
        iconData: Icons.tune,
        label: "Tune Image",
        type: ToolsType.TuneImage,
      ),
      ToolsItemModel(
        iconData: Icons.change_history,
        label: "Details",
        type: ToolsType.Details,
      ),
      ToolsItemModel(
        iconData: Icons.star_rate,
        label: "Curves",
        type: ToolsType.Curves,
      ),
      ToolsItemModel(
        iconData: Icons.exposure,
        label: "White balance",
        type: ToolsType.WhiteBalance,
      ),
      ToolsItemModel(
        iconData: Icons.crop,
        label: "Crop",
        type: ToolsType.Crop,
      ),
      ToolsItemModel(
        iconData: Icons.rotate_90_degrees_ccw_sharp,
        label: "Rotate",
        type: ToolsType.Rotate,
      ),
      ToolsItemModel(
        iconData: Icons.crop_16_9,
        label: "Perspective",
        type: ToolsType.Perspective,
      ),
      ToolsItemModel(
        iconData: Icons.self_improvement,
        label: "Expand",
        type: ToolsType.Expand,
      ),
      ToolsItemModel(
        iconData: Icons.radio_button_checked,
        label: "Selective",
        type: ToolsType.Selective,
      ),
      ToolsItemModel(
        iconData: Icons.brush,
        label: "Brush",
        type: ToolsType.Brush,
      ),
      ToolsItemModel(
        iconData: Icons.healing,
        label: "Healing",
        type: ToolsType.Healing,
      ),
      ToolsItemModel(
        iconData: Icons.filter_alt_outlined,
        label: "HDR-scape",
        type: ToolsType.HDRScape,
      ),
      ToolsItemModel(
        iconData: Icons.tune,
        label: "Glamour glow",
        type: ToolsType.GlamourGlow,
      ),
      ToolsItemModel(
        iconData: Icons.filter_alt_outlined,
        label: "Tonal constrast",
        type: ToolsType.TonalConstrast,
      ),
      ToolsItemModel(
        iconData: Icons.filter_hdr_sharp,
        label: "Drama",
        type: ToolsType.Drama,
      ),
      ToolsItemModel(
        iconData: Icons.filter_vintage,
        label: "Vintage",
        type: ToolsType.Vintage,
      ),
      ToolsItemModel(
        iconData: Icons.flip_camera_android,
        label: "Grainy film",
        type: ToolsType.GrainyFilm,
      ),
      ToolsItemModel(
        iconData: Icons.repeat_rounded,
        label: "Retrolux",
        type: ToolsType.Retrolux,
      ),
      ToolsItemModel(
        iconData: Icons.tune,
        label: "Grunge",
        type: ToolsType.Grunge,
      ),
      ToolsItemModel(
        iconData: Icons.filter_b_and_w,
        label: "Black and white",
        type: ToolsType.BlackAndwhite,
      ),
      ToolsItemModel(
        iconData: Icons.tune,
        label: "Noir",
        type: ToolsType.Noir,
      ),
      ToolsItemModel(
        iconData: Icons.face,
        label: "Portrait",
        type: ToolsType.Portrait,
      ),
      ToolsItemModel(
        iconData: Icons.tag_faces,
        label: "Head pose",
        type: ToolsType.HeadPose,
      ),
      ToolsItemModel(
        iconData: Icons.blur_circular,
        label: "Lens Blur",
        type: ToolsType.LensBlur,
      ),
      ToolsItemModel(
        iconData: Icons.circle,
        label: "Vignette",
        type: ToolsType.Vignette,
      ),
      ToolsItemModel(
        iconData: Icons.double_arrow_rounded,
        label: "Double Exposure",
        type: ToolsType.DoubleExposure,
      ),
      ToolsItemModel(
        iconData: Icons.text_fields,
        label: "Text",
        type: ToolsType.Text,
      ),
      ToolsItemModel(
        iconData: Icons.filter_frames,
        label: "Frames",
        type: ToolsType.Frames,
      ),
    ];
  }
}
