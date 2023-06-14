import 'package:habit_tracker/models/habit.dart';

class HabitsListEvent {
  const HabitsListEvent();
}

class AddNewHabit extends HabitsListEvent {
  Habit habit;
  AddNewHabit({required this.habit});
}

class RemoveHabit extends HabitsListEvent {
  Habit habit;
  RemoveHabit({required this.habit});
}
