import 'package:flutter/material.dart';
import 'package:flutter_image_editor/constants/config_constant.dart';
import 'package:flutter_image_editor/notifiers/image_notifier.dart';
import 'package:flutter_image_editor/widgets/fie_appbar.dart';
import 'package:hooks_riverpod/all.dart';

class HomeScreen extends ConsumerWidget {
  void _chooseImage(BuildContext context, ImageNotifier notifier) async {
    await notifier.pickAnImage();
    if (notifier.requestStatus) {
      print(notifier.image);
      Navigator.pushReplacementNamed(context, '/editing');
    }
  }

  @override
  Widget build(BuildContext context, reader) {
    var notifier = reader(imageNotifier);
    return Scaffold(
      appBar: FieAppBar(),
      body: GestureDetector(
        onTap: () => _chooseImage(context, notifier),
        child: buildBody(context),
      ),
      bottomNavigationBar: const SizedBox(
        height: ConfigConstant.toolbarHeight,
      ),
    );
  }

  Widget buildBody(BuildContext context) {
    return Center(
      child: Wrap(
        direction: Axis.vertical,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          Container(
            width: ConfigConstant.objectHeight5,
            height: ConfigConstant.objectHeight5,
            margin: buildEdgeInsets(),
            decoration: buildBoxDecoration(),
            child: Icon(
              Icons.add_a_photo,
              size: ConfigConstant.iconSize2,
            ),
          ),
          Text(
            'Tap anywhere to open a photo',
            style: Theme.of(context).textTheme.bodyText1,
          )
        ],
      ),
    );
  }

  EdgeInsets buildEdgeInsets() {
    return const EdgeInsets.only(
      bottom: ConfigConstant.margin2,
    );
  }

  BoxDecoration buildBoxDecoration() {
    return BoxDecoration(
      color: Colors.black.withOpacity(0.05),
      borderRadius: BorderRadius.circular(
        ConfigConstant.objectHeight5,
      ),
    );
  }
}
