import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_tracker/bloc/records_list/records_list_bloc.dart';
import 'package:habit_tracker/bloc/records_list/records_list_event.dart';
import 'package:habit_tracker/models/date.dart';
import 'package:habit_tracker/models/goal.dart';
import 'package:habit_tracker/models/habit.dart';
import 'package:habit_tracker/models/record.dart';

class HabitBox extends StatefulWidget {
  const HabitBox(
      {super.key,
      required this.habit,
      required this.date,
      required this.record});
  final Habit habit;
  final Record? record;
  final Date date;

  @override
  State<HabitBox> createState() => _HabitBoxState();
}

class _HabitBoxState extends State<HabitBox> {
  //Initializing States
  late var draggedWidth;
  late var goalCountCompleted;
  late var widthOfOneInterval;
  var firstLoad = true;

  @override
  void didChangeDependencies() {
    if (firstLoad) {
      var deviceWidth = MediaQuery.of(context).size.width;
      //For Margins
      var widgetWidth = deviceWidth - 16.0;
      widthOfOneInterval = widgetWidth / widget.habit.goal.goalCount;
      goalCountCompleted =
          widget.record == null ? 0 : widget.record!.countCompleted;
      draggedWidth = widget.record == null
          ? 0.0
          : widget.record!.countCompleted * widthOfOneInterval;
      firstLoad = false;
    }
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant HabitBox oldWidget) {
    // setState(() {
    draggedWidth = widget.record == null
        ? 0.0
        : widget.record!.countCompleted * widthOfOneInterval;
    // });
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragUpdate: (details) {
        setState(() {
          draggedWidth = details.localPosition.dx;
          goalCountCompleted =
              ((details.localPosition.dx - (widthOfOneInterval / 2)) /
                      widthOfOneInterval)
                  .ceil();
        });
      },
      onHorizontalDragEnd: (details) {
        setState(() {
          draggedWidth = goalCountCompleted * widthOfOneInterval;
        });
        context.read<RecordListBloc>().add(
              AddOrUpdateRecord(
                record: Record(
                    habitName: widget.habit.name,
                    countCompleted: goalCountCompleted,
                    date: widget.date),
              ),
            );
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
              child: Container(
                decoration: BoxDecoration(
                  color: widget.habit.color,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                width: draggedWidth,
              ),
            ),
            //Transparent Box That contains all the text and icon
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white.withAlpha(0),
                borderRadius: const BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              child: Row(
                children: [
                  Expanded(flex: 1, child: widget.habit.icon),
                  const SizedBox(width: 10),
                  Expanded(
                    flex: 6,
                    child: Text(
                      widget.habit.name,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const Expanded(child: SizedBox()),
                  Expanded(
                    flex: 2,
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: Text(
                        "${widget.record == null ? 0 : widget.record!.countCompleted}/${widget.habit.goal.goalCount} ${widget.habit.goal.goalUnit == GoalUnit.count ? "" : Goal.goalUnits[widget.habit.goal.goalUnit]}",
                        style: const TextStyle(fontSize: 12),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
