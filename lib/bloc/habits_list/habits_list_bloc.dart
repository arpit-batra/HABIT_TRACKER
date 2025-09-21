import 'dart:convert';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:habit_tracker/bloc/habits_list/habits_list_event.dart';
import 'package:habit_tracker/bloc/habits_list/habits_list_state.dart';
import 'package:habit_tracker/main.dart';
import 'package:habit_tracker/models/habit.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:timezone/timezone.dart' as tz;

class HabitsListBloc extends HydratedBloc<HabitsListEvent, HabitsListState> {
  HabitsListBloc() : super(HabitsListState(habits: [])) {
    on((AddNewHabit event, emit) async {
      if (state.habits.any(
        (element) => element.name == event.habit.name,
      )) {
        emit(SameHabitNameErrorState(
            errorMessage:
                "Habit with same name already exists, Kindly change the habit name",
            habits: state.habits));
      } else {
        //Adding notification
        await _zonedScheduleNotification(event.habit);
        emit(HabitsListState(habits: [...state.habits, event.habit]));
      }
    });

    on((RemoveHabit event, emit) async {
      final temp = state.habits;
      _removeScheduledNotification(event.habit);
      temp.remove(event.habit);
      emit(HabitsListState(habits: temp));
    });

    on((UpdateHabit event, emit) {
      final temp = state.habits;
      final targetIndex =
          temp.indexWhere((element) => element.name == event.habitName);
      final targetHabit =
          temp.firstWhere((element) => element.name == event.habitName);
      final newHabit = targetHabit.copyWith(
          endDate: event.newEndDate ?? targetHabit.endDate);
      temp[targetIndex] = newHabit;
      emit(HabitsListState(habits: temp));
    });
  }

  Future<void> _removeScheduledNotification(Habit habit) async {
    int index = 0;
    for (final reminder in habit.reminders) {
      await flutterLocalNotificationsPlugin.cancel((habit.id * 10) + index);
      index++;
    }
  }

  Future<void> _zonedScheduleNotification(Habit habit) async {
    int index = 0;
    for (final reminder in habit.reminders) {
      flutterLocalNotificationsPlugin.zonedSchedule(
          (habit.id * 10) + index,
          habit.name,
          "Knock Knock, here's your reminder for today",
          tz.TZDateTime(
              tz.local,
              habit.startDate.year,
              habit.startDate.month,
              habit.startDate.date,
              reminder.hour,
              reminder.minute,
              reminder.second),
          const NotificationDetails(
              android: AndroidNotificationDetails(
                  'reminders', 'Habit Reminders',
                  channelDescription:
                      'These notifications will remind you to complete your tasks on times mentioned by you')),
          uiLocalNotificationDateInterpretation:
              UILocalNotificationDateInterpretation.absoluteTime,
          matchDateTimeComponents: DateTimeComponents.time,
          androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle);
      index++;
    }
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
