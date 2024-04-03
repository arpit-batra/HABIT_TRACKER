import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:habit_tracker/models/date.dart';
import 'package:habit_tracker/models/goal.dart';
import 'package:habit_tracker/models/habit.dart';

class NewHabitCubit extends Cubit<Habit> {
  NewHabitCubit()
      : super(
          Habit(
              id: -1,
              icon: const FaIcon(FontAwesomeIcons.personRunning),
              color: Colors.blue,
              goal: Goal(),
              name: "New Habit",
              startDate: Date.today(),
              endDate: Date(date: 1, month: 1, year: 2100),
              reminders: []),
        );

  setHabitName(String newName) {
    emit(state.copyWith(name: newName));
  }

  setHabitColor(Color newColor) {
    emit(state.copyWith(color: newColor));
  }

  setHabitIcon(FaIcon newIcon) {
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

  addHabitReminder(TimeOfDay timeOfDay) {
    var temp = state.reminders;
    temp.add(DateTime(1900, 1, 1, timeOfDay.hour, timeOfDay.minute));
    emit(state.copyWith(reminders: temp));
  }

  removeHabitReminder(TimeOfDay timeOfDay) {
    var temp = state.reminders;
    temp.removeWhere((element) =>
        element.hour == timeOfDay.hour && element.minute == timeOfDay.minute);
    emit(state.copyWith(reminders: temp));
  }
}
