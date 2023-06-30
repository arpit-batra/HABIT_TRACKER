import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:habit_tracker/models/date.dart';
import 'package:habit_tracker/models/goal.dart';
import 'package:json_annotation/json_annotation.dart';

part 'habit.g.dart';

class ColorConverter extends JsonConverter<Color, Map<String, dynamic>> {
  const ColorConverter();

  @override
  Color fromJson(Map<String, dynamic> json) {
    return Color.fromARGB(
        json["alpha"], json["red"], json["green"], json["blue"]);
  }

  @override
  Map<String, dynamic> toJson(Color object) {
    return {
      "alpha": object.alpha,
      "red": object.red,
      "green": object.green,
      "blue": object.blue
    };
  }
}

class IconConverter extends JsonConverter<FaIcon, Map<String, dynamic>> {
  const IconConverter();

  @override
  FaIcon fromJson(Map<String, dynamic> json) {
    return FaIcon(IconDataSolid(json["iconData"]));
  }

  @override
  Map<String, dynamic> toJson(FaIcon object) {
    return {"iconData": object.icon == null ? 0 : object.icon!.codePoint};
  }
}

@JsonSerializable(converters: [ColorConverter(), IconConverter()])
class Habit {
  Habit({
    required this.id,
    required this.name,
    required this.color,
    required this.goal,
    required this.icon,
    required this.startDate,
    required this.endDate,
  });
  int id;
  String name;
  Color color;
  Goal goal;
  FaIcon icon;
  Date startDate;
  Date endDate;

  Habit copyWith(
      {String? name,
      Color? color,
      String? emoji,
      Goal? goal,
      FaIcon? icon,
      Date? startDate,
      Date? endDate}) {
    return Habit(
      id: id,
      name: name ?? this.name,
      color: color ?? this.color,
      goal: goal ?? this.goal,
      icon: icon ?? this.icon,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
    );
  }

  factory Habit.fromJson(Map<String, dynamic> json) => _$HabitFromJson(json);
  Map<String, dynamic> toJson() => _$HabitToJson(this);
}
