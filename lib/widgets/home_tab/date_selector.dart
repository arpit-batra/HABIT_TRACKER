import 'package:flutter/material.dart';
import 'package:habit_tracker/helper/date_helper.dart';
import 'package:habit_tracker/widgets/home_tab/date_widget.dart';

class DateSelector extends StatelessWidget {
  DateSelector({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Container(
      width: screenWidth,
      // color: Colors.amber,
      height: 80,
      child: PageView.builder(
        itemBuilder: (context, index) {
          final week = DateHelper.getWeekFromIndex(index);
          return SizedBox(
            width: screenWidth,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: week
                  .map(
                      (date) => DateWidget(date: date, totalWidth: screenWidth))
                  .toList(),
            ),
          );
        },
        scrollDirection: Axis.horizontal,
        controller:
            PageController(initialPage: DateHelper.getCurrentWeekNumber()),
      ),
    );
  }
}
