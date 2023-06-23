import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_tracker/bloc/records_list/records_list_bloc.dart';
import 'package:habit_tracker/bloc/records_list/records_list_state.dart';
import 'package:habit_tracker/bloc/selected_habit.dart/selected_habit_bloc.dart';
import 'package:habit_tracker/helper/date_helper.dart';
import 'package:habit_tracker/models/habit.dart';
import 'package:habit_tracker/models/record.dart';

class HabitCalendar extends StatefulWidget {
  const HabitCalendar({super.key});

  @override
  State<HabitCalendar> createState() => _HabitCalendarState();
}

class _HabitCalendarState extends State<HabitCalendar> {
  late int month;
  late int year;
  late DateTime firstDateOfSelectedMonth;

  @override
  void initState() {
    final currDate = DateTime.now();
    month = currDate.month;
    year = currDate.year;
    firstDateOfSelectedMonth = DateHelper.getFirstDayOfCurrentMonth();
    super.initState();
  }

  List<Widget> _weekDayHeadings() {
    return DateHelper.weekDaysArray
        .map((e) => Text(
              e.leadingChar,
              textAlign: TextAlign.center,
            ))
        .toList();
  }

  void _decreaseMonth() {
    setState(() {
      if (month == 1) {
        month = 12;
        year--;
      } else {
        month--;
      }
      firstDateOfSelectedMonth =
          DateHelper.getFirstDayOfPreviousMonth(firstDateOfSelectedMonth);
    });
  }

  void _increaseMonth() {
    setState(() {
      if (month == 12) {
        month = 1;
        year++;
      } else {
        month++;
      }
      firstDateOfSelectedMonth =
          DateHelper.getFirstDayOfNextMonth(firstDateOfSelectedMonth);
    });
  }

  List<Widget> _allDaysOfTheSelectedMonth(
      List<Record> selectedHabitRecords, Habit? selectedHabit) {
    List<Widget> ans = [];
    List<DateTime> allDates =
        DateHelper.getAllDatesOfMonthWhoseFirstDateIs(firstDateOfSelectedMonth);
    for (int i = 0; i < firstDateOfSelectedMonth.weekday - 1; i++)
      ans.add(Container());
    for (int i = 0; i < allDates.length; i++) {
      var prefferedOpacity = 0.0;
      if (selectedHabitRecords
              .where((element) =>
                  element.date == DateHelper.convertDateTimeToDate(allDates[i]))
              .isNotEmpty &&
          selectedHabit != null) {
        final thisDatesRecord = selectedHabitRecords.firstWhere((element) =>
            element.date == DateHelper.convertDateTimeToDate(allDates[i]));
        prefferedOpacity =
            (thisDatesRecord.countCompleted / selectedHabit.goal.goalCount) *
                255;
      }
      ans.add(Container(
        margin: EdgeInsets.all(6),
        decoration: BoxDecoration(
            color: selectedHabit != null
                ? selectedHabit.color.withAlpha(prefferedOpacity.ceil())
                : const Color.fromARGB(0, 0, 0, 0),
            borderRadius: BorderRadius.all(Radius.circular(6))),
        child: Center(
          child: Text(
            allDates[i].day.toString(),
            textAlign: TextAlign.center,
          ),
        ),
      ));
    }
    return ans;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
                onPressed: () {
                  _decreaseMonth();
                },
                icon: const Icon(Icons.arrow_back_ios)),
            Flexible(
              child: Text(
                "$month/$year",
                overflow: TextOverflow.ellipsis,
              ),
            ),
            IconButton(
                onPressed: () {
                  _increaseMonth();
                },
                icon: const Icon(Icons.arrow_forward_ios)),
          ],
        ),
        // Column(children: [Row(ch)],)
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: _weekDayHeadings(),
        ),
        const SizedBox(
          height: 20,
        ),
        BlocBuilder<SelectedHabitBloc, Habit?>(
          builder: (context, selectedHabitState) {
            return BlocBuilder<RecordListBloc, RecordsListState>(
              builder: (context, recordListState) {
                List<Record> selectedHabitRecords = [];
                if (selectedHabitState != null) {
                  selectedHabitRecords = recordListState.recordList
                      .where((element) =>
                          element.habitName == selectedHabitState.name)
                      .toList();
                }
                return GridView.count(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  crossAxisCount: 7,
                  childAspectRatio: 1,
                  children: _allDaysOfTheSelectedMonth(
                      selectedHabitRecords, selectedHabitState),
                );
              },
            );
          },
        ),
      ],
    );
  }
}
