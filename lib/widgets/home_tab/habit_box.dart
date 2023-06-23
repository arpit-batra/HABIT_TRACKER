import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_tracker/bloc/habits_list/habits_list_bloc.dart';
import 'package:habit_tracker/bloc/habits_list/habits_list_event.dart';
import 'package:habit_tracker/bloc/records_list/records_list_bloc.dart';
import 'package:habit_tracker/bloc/records_list/records_list_event.dart';
import 'package:habit_tracker/helper/date_helper.dart';
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

class _HabitBoxState extends State<HabitBox> with TickerProviderStateMixin {
  //Initializing States
  late var draggedWidth;
  late var goalCountCompleted;
  late var widthOfOneInterval;
  late AnimationController animationController;
  late Animation animation;
  var firstLoad = true;
  var _isExpanded = false;
  var _buttonsVisible = false;

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
      animationController = AnimationController(
          vsync: this, duration: const Duration(milliseconds: 400));
      animation = Tween<double>(begin: 0.0, end: 60.0).animate(
          CurvedAnimation(parent: animationController, curve: Curves.easeIn));
      firstLoad = false;
    }
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant HabitBox oldWidget) {
    draggedWidth = widget.record == null
        ? 0.0
        : widget.record!.countCompleted * widthOfOneInterval;
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (_isExpanded) {
          setState(() {
            _buttonsVisible = false;
          });
        } else {
          animationController.forward().then((value) {
            setState(() {
              _buttonsVisible = true;
            });
          });
          setState(() {
            _isExpanded = true;
          });
        }
      },
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
      child: Column(
        children: [
          Container(
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
                  height: 50,
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
          //Container that is supposed to be visible when user taps on it
          AnimatedBuilder(
            animation: animation,
            builder: (context, child) {
              return Container(
                // color: Colors.amber,
                padding: const EdgeInsets.all(8),
                height: animation.value,
                child: Row(children: [
                  Expanded(
                    child: AnimatedOpacity(
                      onEnd: () {
                        if (!_buttonsVisible) {
                          setState(() {
                            _isExpanded = false;
                          });
                          animationController.reverse();
                        }
                      },
                      opacity: _buttonsVisible ? 1 : 0,
                      duration: const Duration(milliseconds: 300),
                      child: GestureDetector(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (ctx) {
                                return AlertDialog(
                                  title: Text(
                                    "This will erase all the records of this habit in the past. Do you want to Continue?",
                                    style:
                                        Theme.of(context).textTheme.titleSmall,
                                  ),
                                  actions: [
                                    ElevatedButton(
                                      onPressed: () {
                                        context.read<RecordListBloc>().add(
                                            RemoveRecordsOfAHabit(
                                                habit: widget.habit));
                                        context.read<HabitsListBloc>().add(
                                            RemoveHabit(habit: widget.habit));
                                        Navigator.of(context).pop();
                                      },
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                Theme.of(context)
                                                    .colorScheme
                                                    .error),
                                      ),
                                      child: const Text("Yes"),
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                Theme.of(context)
                                                    .colorScheme
                                                    .background),
                                      ),
                                      child: const Text("No"),
                                    )
                                  ],
                                );
                              });
                        },
                        child: Column(
                          children: [
                            Icon(
                              Icons.delete,
                              color: Theme.of(context).colorScheme.error,
                            ),
                            Text(
                              "Permenantly Delete the Habit",
                              style: TextStyle(
                                  fontSize: 12,
                                  color: Theme.of(context).colorScheme.error),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: AnimatedOpacity(
                      opacity: _buttonsVisible ? 1 : 0,
                      duration: const Duration(milliseconds: 300),
                      child: GestureDetector(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (ctx) {
                                return AlertDialog(
                                  title: Text(
                                    "This habit will not be recorded from tomorrow. Do you want to continue?",
                                    style:
                                        Theme.of(context).textTheme.titleSmall,
                                  ),
                                  actions: [
                                    ElevatedButton(
                                      onPressed: () {
                                        context.read<HabitsListBloc>().add(
                                            UpdateHabit(
                                                habitName: widget.habit.name,
                                                newEndDate: DateHelper
                                                    .convertDateTimeToDate(
                                                        DateTime.now().add(
                                                            const Duration(
                                                                days: 1)))));
                                        Navigator.of(context).pop();
                                        setState(() {
                                          _buttonsVisible = false;
                                        });
                                      },
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                Theme.of(context)
                                                    .colorScheme
                                                    .error),
                                      ),
                                      child: const Text("Yes"),
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                Theme.of(context)
                                                    .colorScheme
                                                    .background),
                                      ),
                                      child: const Text("No"),
                                    )
                                  ],
                                );
                              });
                        },
                        child: Column(
                          children: [
                            Icon(
                              Icons.stop_circle_outlined,
                              color: Theme.of(context).colorScheme.error,
                            ),
                            Text(
                              "End Habit",
                              style: TextStyle(
                                  fontSize: 12,
                                  color: Theme.of(context).colorScheme.error),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ]),
              );
            },
          ),
        ],
      ),
    );
  }
}
