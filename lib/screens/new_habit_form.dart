import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:habit_tracker/bloc/habits_list/habits_list_bloc.dart';
import 'package:habit_tracker/bloc/habits_list/habits_list_event.dart';
import 'package:habit_tracker/bloc/new_habit_form.dart/new_habit_cubit.dart';
import 'package:habit_tracker/models/habit_model.dart';
import 'package:habit_tracker/widgets/new_habit_form/color_selector.dart';
import 'package:habit_tracker/widgets/new_habit_form/goal_selector.dart';
import 'package:habit_tracker/widgets/new_habit_form/icon_selector.dart';
import 'package:habit_tracker/widgets/new_habit_form/name_selector.dart';
import 'package:habit_tracker/widgets/tab_headings.dart';
import 'package:icon_picker/icon_picker.dart';

class NewHabitForm extends StatefulWidget {
  NewHabitForm({super.key});

  @override
  State<NewHabitForm> createState() => _NewHabitFormState();
}

class _NewHabitFormState extends State<NewHabitForm> {
  GlobalKey _formKey = GlobalKey<FormState>();
  final Map<String, IconData> myIconCollection = {
    'favorite': Icons.favorite,
    'home': Icons.home,
    'android': Icons.android,
    'album': Icons.album,
    'ac_unit': Icons.ac_unit,
  };

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: NewHabitCubit(),
      child: Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              Column(
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: IconButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            icon: const Icon(Icons.arrow_back)),
                      ),
                      Flexible(
                        child: BlocBuilder<NewHabitCubit, Habit>(
                          builder: (context, state) {
                            return TabHeading(heading: state.name);
                          },
                        ),
                      )
                    ],
                  ),
                  Form(
                    key: _formKey,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Name",
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          const NameSelector(),
                          const SizedBox(
                            height: 30,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Column(
                                children: [
                                  Text(
                                    "Icon",
                                    style:
                                        Theme.of(context).textTheme.titleMedium,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  const IconSelector(),
                                ],
                              ),
                              const SizedBox(
                                width: 100,
                              ),
                              Column(
                                children: [
                                  Text(
                                    "Color",
                                    style:
                                        Theme.of(context).textTheme.titleMedium,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  const ColorSelector(),
                                ],
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Text(
                            "Goal",
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          const GoalSelector(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: BlocBuilder<NewHabitCubit, Habit>(
                  builder: (context, state) {
                    return GestureDetector(
                      onTap: () {
                        final newHabit = state;

                        context
                            .read<HabitsListBloc>()
                            .add(AddNewHabit(habit: newHabit));
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        padding: EdgeInsets.all(32),
                        color: Theme.of(context).primaryColor,
                        child: Center(
                          child: Text(
                            "Submit",
                            style: Theme.of(context).textTheme.labelLarge,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
