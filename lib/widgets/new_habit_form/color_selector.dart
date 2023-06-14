import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:habit_tracker/bloc/new_habit_form.dart/new_habit_cubit.dart';
import 'package:habit_tracker/models/habit.dart';

class ColorSelector extends StatefulWidget {
  const ColorSelector({super.key});

  @override
  State<ColorSelector> createState() => _ColorSelectorState();
}

class _ColorSelectorState extends State<ColorSelector> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewHabitCubit, Habit>(
      builder: (context, state) {
        return Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(shape: BoxShape.circle, color: state.color),
          child: GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                builder: (ctx) {
                  return SimpleDialog(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          "Color",
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: ColorPicker(
                          pickerColor: Colors.black,
                          onColorChanged: (color) {
                            context.read<NewHabitCubit>().setHabitColor(color);
                          },
                          showLabel: false,
                          enableAlpha: false,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text("OK")),
                      )
                    ],
                  );
                },
              );
            },
          ),
        );
      },
    );
  }
}
