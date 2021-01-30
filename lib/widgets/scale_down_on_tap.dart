import 'package:flutter/material.dart';

class ScaleDownOnTab extends StatefulWidget {
  const ScaleDownOnTab({
    Key key,
    @required this.child,
    this.onTap,
    this.onLongPress,
    this.scale = 0.95,
  }) : super(key: key);
  final Function onTap;
  final Function onLongPress;
  final Widget child;
  final double scale;
  @override
  _ScaleDownOnTabState createState() => _ScaleDownOnTabState();
}

class _ScaleDownOnTabState extends State<ScaleDownOnTab> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 100),
      vsync: this,
    );

    _animation = Tween<double>(begin: 1, end: widget.scale).animate(_controller);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (val) {
        _controller.forward();
      },
      onTapCancel: () {
        _controller.reverse();
      },
      onTapUp: (val) {
        _controller.reverse();
      },
      onTap: widget.onTap ?? () {},
      onLongPress: widget.onLongPress ?? null,
      child: ScaleTransition(
        scale: _animation,
        child: widget.child,
      ),
    );
  }
}
