import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_tracker/bloc/new_habit_form.dart/new_habit_cubit.dart';

class NameSelector extends StatelessWidget {
  const NameSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: Theme.of(context).primaryColor,
      decoration: InputDecoration(
        // fillColor: Colors.amber,
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
              color: Theme.of(context).textTheme.titleMedium!.color!),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).primaryColor),
        ),

        // focusColor: Theme.of(context).primaryColor,
      ),
      validator: (value) {
        if (value == "" || value == null) {
          return "Please enter a valid name";
        }
        return null;
      },
      // onSaved: (newValue) {
      //   context.read<NewHabitCubit>().setHabitName(newValue!);
      // },
      onChanged: (value) {
        context.read<NewHabitCubit>().setHabitName(value);
      },
      initialValue: "New Habit",
    );
  }
}
