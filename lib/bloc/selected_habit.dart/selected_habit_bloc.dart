import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_tracker/bloc/selected_habit.dart/selected_habit_event.dart';
import 'package:habit_tracker/models/habit.dart';

class SelectedHabitBloc extends Bloc<SelectedHabitEvent, Habit?> {
  SelectedHabitBloc() : super(null) {
    on((SelectedHabitChanged event, emit) {
      emit(event.newSelectedHabit);
    });
  }
}
