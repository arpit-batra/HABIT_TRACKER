import 'package:flutter/material.dart';
import 'package:habit_tracker/widgets/tab_headings.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    return SizedBox(
      width: deviceWidth,
      height: double.infinity,
      child: SafeArea(
          child: Column(
        children: const [TabHeading(heading: "Home")],
      )),
    );
  }
}
