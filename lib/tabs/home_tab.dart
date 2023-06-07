import 'dart:math';

import 'package:flutter/material.dart';
import 'package:habit_tracker/bloc/habits_list/habits_list_bloc.dart';
import 'package:habit_tracker/bloc/habits_list/habits_list_state.dart';
import 'package:habit_tracker/bloc/selected_date/selected_date_bloc.dart';
import 'package:habit_tracker/bloc/selected_date/selected_date_state.dart';
import 'package:habit_tracker/helper/date_helper.dart';
import 'package:habit_tracker/screens/home_screen.dart';
import 'package:habit_tracker/screens/new_habit_form.dart';
import 'package:habit_tracker/widgets/home_tab/date_selector.dart';
import 'package:habit_tracker/widgets/tab_headings.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  //Route to go to NewHabitForm Screen
  Route _createRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) {
        return NewHabitForm();
      },
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final tween = Tween(
          begin: 0.0,
          end: 1.0,
        ).animate(CurvedAnimation(parent: animation, curve: Curves.easeIn));

        return FadeTransition(
          opacity: tween,
          child: child,
        );
      },
    );
  }

  Widget newHabitButton(BuildContext context) {
    return Positioned(
      right: 20,
      bottom: HomeScreen.tabSwitcherHeight,
      child: GestureDetector(
        onTap: () {
          HomeScreenState.routeAnimationKey.currentState!
              .setStartAnimationTrue();
          Future.delayed(const Duration(milliseconds: 400))
              .then((value) => Navigator.of(context).push(_createRoute()))
              .then((value) => HomeScreenState.routeAnimationKey.currentState!
                  .setStartAnimationFalse());
        },
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Theme.of(context).primaryColor),
          child: Text(
            "Add New Habit",
            style: Theme.of(context).textTheme.labelMedium,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    return BlocProvider(
      create: (context) => SelectedDateBloc(),
      child: SizedBox(
        width: deviceWidth,
        height: double.infinity,
        child: SafeArea(
            bottom: false,
            child: Stack(
              children: [
                Column(
                  children: [
                    //Tab Heading
                    BlocBuilder<SelectedDateBloc, SelectedDateState>(
                        builder: (context, state) {
                      final homeHeading =
                          DateHelper.homeTabHeading(state.selectedDate);
                      return TabHeading(heading: homeHeading);
                    }),
                    //Date Selector
                    DateSelector(),
                    //List of Habits
                    Expanded(
                      child: BlocBuilder<HabitsListBloc, HabitsListState>(
                        builder: (context, state) {
                          return ListView.builder(
                            itemBuilder: (ctx, index) {
                              final habit = state.habits[index];
                              return Container(
                                margin: const EdgeInsets.all(8),
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: habit.color,
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(5),
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    habit.icon,
                                    const SizedBox(width: 10),
                                    Text(habit.name),
                                  ],
                                ),
                              );
                            },
                            itemCount: state.habits.length,
                          );
                        },
                      ),
                    )
                  ],
                ),
                newHabitButton(context),
              ],
            )),
      ),
    );
  }
}
