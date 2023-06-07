import 'package:flutter/material.dart';
import 'package:habit_tracker/models/goal_model.dart';

class Habit {
  Habit({
    required this.id,
    required this.name,
    required this.color,
    required this.goal,
    required this.icon,
  });
  int id;
  String name;
  Color color;
  Goal goal;
  Icon icon;

  Habit copyWith(
      {String? name, Color? color, String? emoji, Goal? goal, Icon? icon}) {
    return Habit(
      id: id,
      name: name ?? this.name,
      color: color ?? this.color,
      goal: goal ?? this.goal,
      icon: icon ?? this.icon,
    );
  }
}
