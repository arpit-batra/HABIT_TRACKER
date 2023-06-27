import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';
import 'package:habit_tracker/bloc/new_habit_form.dart/new_habit_cubit.dart';
import 'package:habit_tracker/helper/icons_collection.dart';
import 'package:habit_tracker/models/habit.dart';

class IconSelector extends StatefulWidget {
  const IconSelector({super.key});

  @override
  State<IconSelector> createState() => _IconSelectorState();
}

Map<String, IconData> iconsCollection = IconsCollection.iconsCollection;

class _IconSelectorState extends State<IconSelector> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      height: 50,
      decoration:
          const BoxDecoration(shape: BoxShape.circle, color: Colors.black12),
      // color: Colors.black12,
      child: IconButton(
          color: Theme.of(context).primaryColor,
          onPressed: () async {
            IconData? iconData = await FlutterIconPicker.showIconPicker(context,
                iconPackModes: [IconPack.custom],
                customIconPack: iconsCollection,
                iconSize: 30,
                mainAxisSpacing: 7,
                closeChild: const Text(
                  'Close',
                  style: TextStyle(fontSize: 18),
                ));
            context.read<NewHabitCubit>().setHabitIcon(Icon(iconData));
          },
          icon: BlocBuilder<NewHabitCubit, Habit>(
              builder: ((context, state) => state.icon))),
    );
  }
}
