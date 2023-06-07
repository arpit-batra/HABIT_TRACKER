import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_tracker/models/goal_model.dart';
import 'package:habit_tracker/models/habit_model.dart';

class NewHabitCubit extends Cubit<Habit> {
  NewHabitCubit()
      : super(
          Habit(
            id: -1,
            icon: const Icon(Icons.directions_run),
            color: Colors.blue,
            goal: Goal(),
            name: "New Habit",
          ),
        );

  setHabitName(String newName) {
    emit(state.copyWith(name: newName));
  }

  setHabitColor(Color newColor) {
    emit(state.copyWith(color: newColor));
  }

  setHabitIcon(Icon newIcon) {
    emit((state.copyWith(icon: newIcon)));
  }

  setHabitGoalCount(int newGoalCount) {
    emit(state.copyWith(goal: state.goal.copyWith(goalCount: newGoalCount)));
  }

  setHabitGoalUnit(GoalUnit newGoalUnit) {
    emit(state.copyWith(goal: state.goal.copyWith(goalUnit: newGoalUnit)));
  }

  setHabitGoalFrequency(int newGoalFrequency) {
    emit(
        state.copyWith(goal: state.goal.copyWith(frequency: newGoalFrequency)));
  }
}
