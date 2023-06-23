import 'package:habit_tracker/models/habit.dart';

class HabitsListState {
  List<Habit> habits;
  HabitsListState({required this.habits});
}

class SameHabitNameErrorState extends HabitsListState {
  final String errorMessage;
  List<Habit> habits;
  SameHabitNameErrorState({required this.errorMessage, required this.habits})
      : super(habits: habits);
}
