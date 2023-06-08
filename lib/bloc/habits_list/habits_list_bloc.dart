import 'dart:convert';

import 'package:habit_tracker/bloc/habits_list/habits_list_event.dart';
import 'package:habit_tracker/bloc/habits_list/habits_list_state.dart';
import 'package:habit_tracker/models/habit_model.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class HabitsListBloc extends HydratedBloc<HabitsListEvent, HabitsListState> {
  HabitsListBloc() : super(HabitsListState(habits: [])) {
    on((AddNewHabit event, emit) {
      emit(HabitsListState(habits: [...state.habits, event.habit]));
    });

    on((RemoveHabit event, emit) {
      final temp = state.habits;
      temp.remove(event.habit);
      emit(HabitsListState(habits: temp));
    });
  }

  @override
  HabitsListState? fromJson(Map<String, dynamic> json) {
    List<dynamic> jsonList = jsonDecode(json["list"]);
    List<Habit> habitList = [];
    jsonList.forEach((habitJson) {
      habitList.add(Habit.fromJson(habitJson));
    });
    return HabitsListState(habits: habitList);
  }

  @override
  Map<String, dynamic>? toJson(HabitsListState state) {
    return {"list": jsonEncode(state.habits)};
  }
}
