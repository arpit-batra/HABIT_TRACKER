import 'package:flutter/material.dart';
import 'package:habit_tracker/widgets/tab_headings.dart';

class HabitTrackerTab extends StatelessWidget {
  const HabitTrackerTab({super.key});

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    return SizedBox(
      height: double.infinity,
      width: deviceWidth,
      child: SafeArea(
        child: Column(
          children: const [TabHeading(heading: "Tracker")],
        ),
      ),
    );
  }
}
