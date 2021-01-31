import 'package:flutter/material.dart';
import 'package:flutter_image_editor/constants/config_constant.dart';
import 'package:flutter_image_editor/screens/editing_screen.dart';
import 'package:flutter_image_editor/widgets/fie_appbar.dart';

class HomeScreen extends StatelessWidget {
  void _chooseImage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return EditingScreen();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: FieAppBar(),
      body: GestureDetector(
        onTap: () => _chooseImage(context),
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
