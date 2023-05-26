import 'dart:math';

import 'package:flutter/material.dart';

class RouteAnimation extends StatefulWidget {
  const RouteAnimation({required this.startingPoint, super.key});

  final Point<double> startingPoint;

  @override
  State<RouteAnimation> createState() => RouteAnimationState();
}

class RouteAnimationState extends State<RouteAnimation> {
  bool startAnimation = false;

  void setStartAnimationTrue() {
    setState(() {
      startAnimation = true;
    });
  }

  void setStartAnimationFalse() {
    setState(() {
      startAnimation = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
        duration: const Duration(milliseconds: 600),
        right: startAnimation ? -400 : widget.startingPoint.x,
        bottom: startAnimation ? -100 : widget.startingPoint.y,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 600),
          decoration: BoxDecoration(
              shape: BoxShape.circle, color: Theme.of(context).primaryColor),
          height: startAnimation ? 1500 : 0,
          width: startAnimation ? 1500 : 0,
        ));
  }
}
