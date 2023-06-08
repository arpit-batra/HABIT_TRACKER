import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';
import 'package:habit_tracker/bloc/new_habit_form.dart/new_habit_cubit.dart';
import 'package:habit_tracker/models/habit_model.dart';

class IconSelector extends StatefulWidget {
  const IconSelector({super.key});

  @override
  State<IconSelector> createState() => _IconSelectorState();
}

Map<String, IconData> iconsCollection = {
  "AC": Icons.ac_unit,
  "alarm": Icons.alarm,
  "accessible": Icons.accessible,
  "wallet": Icons.account_balance_wallet,
  "profile": Icons.account_circle_sharp,
  "add": Icons.add,
  "agriculture": Icons.agriculture,
  "gym": Icons.fitness_center,
  "soccer": Icons.sports_soccer,
  "pool": Icons.pool,
  "baseball": Icons.sports_baseball,
  "basketball": Icons.sports_basketball,
  "running": Icons.directions_run,
  "walking": Icons.directions_walk,
  "cycling": Icons.directions_bike,
};

class _IconSelectorState extends State<IconSelector> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      height: 50,
      decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.black12),
      // color: Colors.black12,
      child: IconButton(
          color: Theme.of(context).primaryColor,
          onPressed: () async {
            IconData? iconData = await FlutterIconPicker.showIconPicker(
              context,
              iconPackModes: [IconPack.custom],
              customIconPack: iconsCollection,
            );
            context.read<NewHabitCubit>().setHabitIcon(Icon(iconData));
          },
          icon: BlocBuilder<NewHabitCubit, Habit>(
              builder: ((context, state) => state.icon))),
    );
  }
}
