import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_tracker/bloc/new_habit_form.dart/new_habit_cubit.dart';
import 'package:habit_tracker/models/goal_model.dart';
import 'package:habit_tracker/models/habit_model.dart';
import 'package:habit_tracker/theme/bloc/theme_bloc.dart';

class GoalSelector extends StatefulWidget {
  const GoalSelector({super.key});

  @override
  State<GoalSelector> createState() => _GoalSelectorState();
}

class _GoalSelectorState extends State<GoalSelector> {
  Widget unit(GoalUnit e) {
    return GestureDetector(
      onTap: () {
        context.read<NewHabitCubit>().setHabitGoalUnit(e);
        Navigator.of(context).pop();
      },
      child: Container(
        padding: const EdgeInsets.all(8),
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(4)),
            color: context.read<ThemeBloc>().state.isNightMode
                ? const Color.fromARGB(255, 78, 78, 78)
                : const Color.fromARGB(255, 206, 206, 206)),
        child: Text(Goal.goalUnits[e]!),
      ),
    );
  }

  Widget frequency(int freq) {
    return GestureDetector(
      onTap: () {
        context.read<NewHabitCubit>().setHabitGoalFrequency(freq);
        Navigator.of(context).pop();
      },
      child: Container(
        padding: const EdgeInsets.all(8),
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(4)),
            color: context.read<ThemeBloc>().state.isNightMode
                ? const Color.fromARGB(255, 78, 78, 78)
                : const Color.fromARGB(255, 206, 206, 206)),
        child: Text(Goal.freqencies[freq]!),
      ),
    );
  }

  Widget unitSelector(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
            context: context,
            builder: (ctx) {
              return SimpleDialog(
                title: const Text("Unit"),
                children: Goal.goalUnits.keys.map((e) => unit(e)).toList(),
              );
            });
      },
      child: Container(
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            color: Colors.black12),
        padding: const EdgeInsets.all(8),
        child: BlocBuilder<NewHabitCubit, Habit>(
          builder: (context, state) {
            return Text(Goal.goalUnits[state.goal.goalUnit]!);
          },
        ),
      ),
    );
  }

  Widget frequencySelector(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
            context: context,
            builder: (ctx) {
              return SimpleDialog(
                children:
                    Goal.freqencies.keys.map((e) => frequency(e)).toList(),
                title: Text("Frequency"),
              );
            });
      },
      child: Container(
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            color: Colors.black12),
        padding: const EdgeInsets.all(8),
        child: BlocBuilder<NewHabitCubit, Habit>(
          builder: (context, state) =>
              Text(Goal.freqencies[state.goal.frequency]!),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          flex: 1,
          child: TextFormField(
            initialValue: "1",
            cursorColor: Theme.of(context).primaryColor,
            decoration: InputDecoration(
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                    color: Theme.of(context).textTheme.titleMedium!.color!),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Theme.of(context).primaryColor),
              ),
            ),
            validator: (value) {
              if (value == "" ||
                  value == null ||
                  value == '0' ||
                  int.tryParse(value) == null) {
                return "Enter valid count";
              }
              return null;
            },
            onChanged: (value) => context
                .read<NewHabitCubit>()
                .setHabitGoalCount(int.parse(value)),
            keyboardType: TextInputType.number,
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Flexible(
          flex: 1,
          child: unitSelector(context),
        ),
        const SizedBox(
          width: 10,
        ),
        Flexible(flex: 1, child: frequencySelector(context))
      ],
    );
  }
}
