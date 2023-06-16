import 'package:habit_tracker/models/habit.dart';

class SelectedHabitEvent {
  const SelectedHabitEvent();
}

class SelectedHabitChanged extends SelectedHabitEvent {
  Habit newSelectedHabit;
  SelectedHabitChanged({required this.newSelectedHabit});
}
