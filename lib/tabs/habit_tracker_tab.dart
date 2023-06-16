import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_tracker/bloc/habits_list/habits_list_bloc.dart';
import 'package:habit_tracker/bloc/habits_list/habits_list_state.dart';
import 'package:habit_tracker/bloc/selected_habit.dart/selected_habit_bloc.dart';
import 'package:habit_tracker/widgets/tab_headings.dart';
import 'package:habit_tracker/widgets/tracker_tab/habit_calendar.dart';
import 'package:habit_tracker/widgets/tracker_tab/habit_selector.dart';

class HabitTrackerTab extends StatelessWidget {
  const HabitTrackerTab({super.key});

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    return BlocProvider.value(
      value: SelectedHabitBloc(),
      child: BlocBuilder<HabitsListBloc, HabitsListState>(
        builder: (context, habitsListState) {
          return SizedBox(
            height: double.infinity,
            width: deviceWidth,
            child: SafeArea(
              child: Column(
                children: [
                  const TabHeading(heading: "Tracker"),
                  HabitSelector(habits: habitsListState.habits),
                  HabitCalendar(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
