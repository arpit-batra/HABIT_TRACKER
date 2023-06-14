import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_tracker/bloc/habits_list/habits_list_bloc.dart';
import 'package:habit_tracker/bloc/habits_list/habits_list_state.dart';
import 'package:habit_tracker/bloc/selected_date/selected_date_bloc.dart';
import 'package:habit_tracker/bloc/selected_date/selected_date_state.dart';
import 'package:habit_tracker/helper/date_helper.dart';
import 'package:habit_tracker/widgets/home_tab/habit_box.dart';

class HabitsListView extends StatelessWidget {
  const HabitsListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HabitsListBloc, HabitsListState>(
      builder: (context, habitsListState) {
        return BlocBuilder<SelectedDateBloc, SelectedDateState>(
            builder: (context, selectedDateState) {
          return ListView.builder(
            itemBuilder: (ctx, index) {
              final habit = habitsListState.habits[index];
              if (DateHelper.isDateABetweenBAndC(selectedDateState.selectedDate,
                      habit.startDate, habit.endDate) ||
                  selectedDateState.selectedDate == habit.startDate) {
                return HabitBox(habit: habit);
              } else {
                return null;
              }
            },
            itemCount: habitsListState.habits.length,
          );
        });
      },
    );
  }
}
