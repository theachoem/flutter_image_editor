import 'package:flutter/material.dart';
import 'package:flutter_image_editor/constants/config_constant.dart';
import 'package:flutter_image_editor/mixins/navigator_mixin.dart';
import 'package:flutter_image_editor/notifiers/editing_notifier.dart';
import 'package:flutter_image_editor/notifiers/image_notifier.dart';
import 'package:flutter_image_editor/notifiers/zoom_notifier.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ImageView extends StatefulWidget {
  const ImageView({
    Key key,
    @required this.notifier,
    @required this.imgNotifier,
  }) : super(key: key);

  final EditingNotifier notifier;
  final ImageNotifier imgNotifier;

  @override
  _ImageViewState createState() => _ImageViewState();
}

class _ImageViewState extends State<ImageView> with NavigatorMixin {
  TransformationController transformationController;

  @override
  void initState() {
    transformationController = TransformationController();
    super.initState();
  }

  @override
  void dispose() {
    transformationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        buildBody(
          notifier: widget.notifier,
          context: context,
          imgNotifier: widget.imgNotifier,
        ),
        Positioned(
          left: ConfigConstant.margin2,
          bottom: ConfigConstant.toolbarHeight * 2,
          child: Consumer(
            builder: (context, reader, child) {
              var zoomNotify = reader(zoomNotifier(transformationController));
              double imageWidth = 120;

              var imageDecode = widget.imgNotifier.imageDecode;
              var decodeNotNull = imageDecode != null && imageDecode.height != null && imageDecode.width != null;

              double imageHeight = decodeNotNull ? imageWidth * imageDecode.height / imageDecode.width : 0;
              if (imageHeight != null && zoomNotify.scale != null) {}

              bool zooming =
                  imageHeight != null && zoomNotify.scale != null && zoomNotify.scale > 1 && zoomNotify.details != null;

              return IgnorePointer(
                ignoring: !zooming,
                child: AnimatedOpacity(
                  duration: ConfigConstant.fadeDuration,
                  opacity: zooming ? 1 : 0,
                  child: Container(
                    width: 120,
                    height: imageHeight,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor.withOpacity(0.2),
                      border: Border.all(
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    child: AspectRatio(
                      aspectRatio: zoomNotify.scale != null ? imageWidth / zoomNotify.scale / imageHeight : 1,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor.withOpacity(0.2),
                          border: Border.all(
                            color: Theme.of(context).accentColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget buildBody({
    EditingNotifier notifier,
    ImageNotifier imgNotifier,
    @required BuildContext context,
  }) {
    var zoomNotify = context.read(zoomNotifier(transformationController));

    var boxDecoration = BoxDecoration(
      borderRadius: BorderRadius.circular(ConfigConstant.objectHeight5),
      color: Colors.black.withOpacity(0.1),
    );
    var margin = EdgeInsets.fromLTRB(
      ConfigConstant.margin1,
      0,
      ConfigConstant.margin1,
      notifier.currentIndex == 0 ? ConfigConstant.objectHeight4 : 0,
    );
    return GestureDetector(
      onTap: () {
        if (notifier.currentIndex != null) {
          closeModal(context);
          notifier.onModalClose();
          return;
        }
      },
      child: Center(
        child: AnimatedContainer(
          duration: ConfigConstant.duration,
          decoration: boxDecoration,
          curve: Curves.easeInQuad,
          margin: margin,
          child: InteractiveViewer(
            transformationController: transformationController,
            onInteractionStart: (ScaleStartDetails detail) {
              notifier.setIsZoom(true);
            },
            onInteractionEnd: (ScaleEndDetails detail) {
              notifier.setIsZoom(false);
            },
            onInteractionUpdate: (ScaleUpdateDetails detail) {
              zoomNotify.setDragDetail(detail);
            },
            child: Image.file(imgNotifier.image),
          ),
        ),
      ),
    );
  }
}
