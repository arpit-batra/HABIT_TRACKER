import 'package:flutter/material.dart';
import 'package:habit_tracker/models/habit.dart';

class HabitBox extends StatefulWidget {
  const HabitBox({super.key, required this.habit});
  final Habit habit;

  @override
  State<HabitBox> createState() => _HabitBoxState();
}

class _HabitBoxState extends State<HabitBox> {
  var draggedWidth = 0.0;
  var goalCountCompleted = 0;
  @override
  Widget build(BuildContext context) {
    var deviceWidth = MediaQuery.of(context).size.width;
    //For Margins
    var widgetWidth = deviceWidth - 16.0;
    var widthOfOneInterval = widgetWidth / widget.habit.goal.goalCount;

    return GestureDetector(
      onHorizontalDragUpdate: (details) {
        setState(() {
          draggedWidth = details.localPosition.dx;
          goalCountCompleted =
              ((details.localPosition.dx - (widthOfOneInterval / 2)) /
                      widthOfOneInterval)
                  .ceil();
        });
        print(goalCountCompleted);
        // print("${widget.habit.name} drag updated");
        // print("Delta -> ${details.delta}");
        // print("Global Position -> ${details.globalPosition}");
        // print("local Position -> ${details.localPosition}");
        // print("primary Delta -> ${details.primaryDelta}");
        // print("sourceTimeStamp -> ${details.sourceTimeStamp}");
      },
      onHorizontalDragEnd: (details) {
        print("during drang end $goalCountCompleted");
        setState(() {
          draggedWidth = goalCountCompleted * widthOfOneInterval;
        });
        //TODO Write the record to the bloc and on the device storage
      },
      child: Container(
        margin: const EdgeInsets.all(8),
        child: Stack(
          children: [
            //Light Color Box
            Positioned(
              left: 0,
              right: 0,
              top: 0,
              bottom: 0,
              child: Container(
                decoration: BoxDecoration(
                  color: widget.habit.color.withAlpha(130),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
              ),
            ),
            //Dark Color Box
            Positioned(
              top: 0,
              bottom: 0,
              child: AnimatedContainer(
                curve: Curves.easeIn,
                duration: const Duration(microseconds: 1900),
                decoration: BoxDecoration(
                  color: widget.habit.color,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                width: draggedWidth,
              ),
            ),
            //Transparent Box
            Container(
              // margin: const EdgeInsets.all(8),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white.withAlpha(0),
                borderRadius: const BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              child: Row(
                children: [
                  widget.habit.icon,
                  const SizedBox(width: 10),
                  Text(
                    widget.habit.name,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const Expanded(child: SizedBox()),
                  Text("${widget.habit.goal.goalCount}"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
