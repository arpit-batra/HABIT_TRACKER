import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_tracker/bloc/habits_list/habits_list_bloc.dart';
import 'package:habit_tracker/bloc/habits_list/habits_list_state.dart';
import 'package:habit_tracker/bloc/selected_date/selected_date_bloc.dart';
import 'package:habit_tracker/bloc/selected_date/selected_date_state.dart';
import 'package:habit_tracker/helper/date_helper.dart';

class HabitsListView extends StatelessWidget {
  const HabitsListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HabitsListBloc, HabitsListState>(
      builder: (context, habitsListState) {
        // print("HabitsListState -> ${habitsListState.habits.length}");
        return BlocBuilder<SelectedDateBloc, SelectedDateState>(
            builder: (context, selectedDateState) {
          return ListView.builder(
            itemBuilder: (ctx, index) {
              final habit = habitsListState.habits[index];
              if (DateHelper.isDateABetweenBAndC(selectedDateState.selectedDate,
                      habit.startDate, habit.endDate) ||
                  selectedDateState.selectedDate == habit.startDate) {
                return Container(
                  margin: const EdgeInsets.all(8),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: habit.color,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(5),
                    ),
                  ),
                  child: Row(
                    children: [
                      habit.icon,
                      const SizedBox(width: 10),
                      Text(habit.name),
                      Text(habit.color.toString()),
                      Text(habit.endDate.toString()),
                      Text(habit.goal.goalCount.toString())
                    ],
                  ),
                );
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
