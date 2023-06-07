import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_tracker/bloc/habits_list/habits_list_event.dart';
import 'package:habit_tracker/bloc/habits_list/habits_list_state.dart';

class HabitsListBloc extends Bloc<HabitsListEvent, HabitsListState> {
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
}
