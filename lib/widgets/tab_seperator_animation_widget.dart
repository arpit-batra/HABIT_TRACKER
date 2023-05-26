import 'package:flutter/material.dart';

enum Direction { left, right }

class TabSeperatorAnimationWidget extends StatefulWidget {
  const TabSeperatorAnimationWidget({required this.direction, super.key});
  final Direction direction;
  @override
  State<TabSeperatorAnimationWidget> createState() =>
      TabSeperatorAnimationWidgetState();
}

class TabSeperatorAnimationWidgetState
    extends State<TabSeperatorAnimationWidget> with TickerProviderStateMixin {
  late AnimationController seperatorWidthAnimationController;
  late AnimationController seperatorLeftAnimationController;
  late AnimationController seperatorRightAnimationController;
  late Animation seperatorWidthAnimation;
  late Animation seperatorLeftAnimation;
  late Animation seperatorRightAnimation;
  late double screenHeight;

  @override
  void initState() {
    seperatorWidthAnimationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 200));
    seperatorLeftAnimationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 200));
    seperatorRightAnimationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 200));
    super.initState();
  }

  @override
  void didChangeDependencies() {
    final screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    //Width
    seperatorWidthAnimation = Tween<double>(begin: 0, end: screenWidth).animate(
        CurvedAnimation(
            parent: seperatorWidthAnimationController, curve: Curves.easeIn));
    //Distance from left corner
    seperatorLeftAnimation = widget.direction == Direction.left
        ? Tween<double>(begin: 0, end: screenWidth).animate(CurvedAnimation(
            parent: seperatorLeftAnimationController, curve: Curves.easeIn))
        : Tween<double>(begin: screenWidth, end: 0).animate(CurvedAnimation(
            parent: seperatorLeftAnimationController, curve: Curves.easeIn));
    //Distance from right corner
    seperatorRightAnimation = widget.direction == Direction.left
        ? Tween<double>(begin: screenWidth, end: 0).animate(CurvedAnimation(
            parent: seperatorRightAnimationController, curve: Curves.easeIn))
        : Tween<double>(begin: 0, end: screenWidth).animate(CurvedAnimation(
            parent: seperatorRightAnimationController, curve: Curves.easeIn));

    super.didChangeDependencies();
  }

  Future<void> startFirstAnimation() async {
    if (widget.direction == Direction.left) {
      seperatorRightAnimationController.forward();
      await seperatorWidthAnimationController.forward();
    } else {
      seperatorLeftAnimationController.forward();
      await seperatorWidthAnimationController.forward();
    }
    return;
  }

  Future<void> startSecondAnimation() async {
    if (widget.direction == Direction.left) {
      seperatorLeftAnimationController.forward();
      await seperatorWidthAnimationController.reverse();
    } else {
      seperatorRightAnimationController.forward();
      await seperatorWidthAnimationController.reverse();
    }
    seperatorLeftAnimationController.reset();
    seperatorRightAnimationController.reset();
    seperatorWidthAnimationController.reset();
    return;
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: seperatorWidthAnimation,
        builder: (context, child) {
          return AnimatedBuilder(
              animation: seperatorLeftAnimation,
              builder: (context, child) {
                return AnimatedBuilder(
                    animation: seperatorRightAnimation,
                    builder: (context, child) {
                      return Positioned(
                          left: seperatorLeftAnimation.value,
                          right: seperatorRightAnimation.value,
                          child: Container(
                            width: seperatorWidthAnimation.value,
                            height: screenHeight,
                            color: Theme.of(context).primaryColor,
                          ));
                    });
              });
        });
  }
}
