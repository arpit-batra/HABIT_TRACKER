import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_tracker/bloc/habits_list/habits_list_bloc.dart';
import 'package:habit_tracker/bloc/habits_list/habits_list_state.dart';
import 'package:habit_tracker/bloc/records_list/records_list_bloc.dart';
import 'package:habit_tracker/bloc/records_list/records_list_state.dart';
import 'package:habit_tracker/bloc/selected_date/selected_date_bloc.dart';
import 'package:habit_tracker/bloc/selected_date/selected_date_state.dart';
import 'package:habit_tracker/helper/date_helper.dart';
import 'package:habit_tracker/theme/bloc/theme_bloc.dart';
import 'package:habit_tracker/theme/bloc/theme_state.dart';
import 'package:habit_tracker/widgets/home_tab/habit_box.dart';

class HabitsListView extends StatelessWidget {
  const HabitsListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HabitsListBloc, HabitsListState>(
      builder: (context, habitsListState) {
        return BlocBuilder<SelectedDateBloc, SelectedDateState>(
            builder: (context, selectedDateState) {
          return BlocBuilder<RecordListBloc, RecordsListState>(
              builder: (context, recordListState) {
            //finding records for the selected date
            final todaysRecords = recordListState.recordList.where(
                (element) => element.date == selectedDateState.selectedDate);
            if (habitsListState.habits.where((habit) {
              return DateHelper.isDateABetweenBAndC(
                      selectedDateState.selectedDate,
                      habit.startDate,
                      habit.endDate) ||
                  selectedDateState.selectedDate == habit.startDate;
            }).isEmpty) {
              return BlocBuilder<ThemeBloc, ThemeState>(
                  builder: (context, state) {
                if (state.isNightMode) {
                  return Image.asset('assets/EmptyHabitsDark.png');
                } else {
                  return Image.asset('assets/EmptyHabits.png');
                }
              });
            } else {
              return ListView.builder(
                itemBuilder: (ctx, index) {
                  final habit = habitsListState.habits[index];
                  //finding records for this habit
                  final todaysRecordsWithThisHabit = todaysRecords
                      .where((element) => element.habitName == habit.name);
                  if (DateHelper.isDateABetweenBAndC(
                          selectedDateState.selectedDate,
                          habit.startDate,
                          habit.endDate) ||
                      selectedDateState.selectedDate == habit.startDate) {
                    return HabitBox(
                      key: Key(habit.name),
                      habit: habit,
                      date: selectedDateState.selectedDate,
                      record: todaysRecordsWithThisHabit.isEmpty
                          ? null
                          : todaysRecordsWithThisHabit.elementAt(0),
                    );
                  } else {
                    return Container();
                  }
                },
                itemCount: habitsListState.habits.length,
              );
            }
          });
        });
      },
    );
  }
}
