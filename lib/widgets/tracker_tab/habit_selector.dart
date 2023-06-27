import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_tracker/bloc/selected_habit.dart/selected_habit_bloc.dart';
import 'package:habit_tracker/bloc/selected_habit.dart/selected_habit_event.dart';
import 'package:habit_tracker/models/habit.dart';

class HabitSelector extends StatelessWidget {
  const HabitSelector({required this.habits, super.key});
  final List<Habit> habits;

  @override
  Widget build(BuildContext context) {
    if (habits.isNotEmpty) {
      context
          .read<SelectedHabitBloc>()
          .add(SelectedHabitChanged(newSelectedHabit: habits[0]));

      return BlocBuilder<SelectedHabitBloc, Habit?>(
          builder: (context, selectedHabitState) {
        return SizedBox(
          height: 50,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: habits.length,
            itemBuilder: (context, index) {
              return IconButton(
                onPressed: () {
                  context.read<SelectedHabitBloc>().add(
                        SelectedHabitChanged(
                          newSelectedHabit: habits[index],
                        ),
                      );
                },
                icon: selectedHabitState != null &&
                        selectedHabitState == habits[index]
                    ? Icon(
                        habits[index].icon.icon,
                        color: selectedHabitState.color,
                      )
                    : habits[index].icon,
              );
            },
          ),
        );
      });
    } else {
      return const Text("No habits added");
    }
  }
}
