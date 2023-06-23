import 'package:habit_tracker/models/habit.dart';
import 'package:habit_tracker/models/record.dart';

class RecordsListEvent {
  RecordsListEvent();
}

class AddOrUpdateRecord extends RecordsListEvent {
  final Record record;
  AddOrUpdateRecord({required this.record});
}

class RemoveRecord extends RecordsListEvent {
  final Record record;
  RemoveRecord({required this.record});
}

class RemoveRecordsOfAHabit extends RecordsListEvent {
  final Habit habit;
  RemoveRecordsOfAHabit({required this.habit});
}
