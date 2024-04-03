// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'habit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Habit _$HabitFromJson(Map<String, dynamic> json) => Habit(
      id: json['id'] as int,
      name: json['name'] as String,
      color: const ColorConverter()
          .fromJson(json['color'] as Map<String, dynamic>),
      goal: Goal.fromJson(json['goal'] as Map<String, dynamic>),
      icon:
          const IconConverter().fromJson(json['icon'] as Map<String, dynamic>),
      startDate: Date.fromJson(json['startDate'] as Map<String, dynamic>),
      endDate: Date.fromJson(json['endDate'] as Map<String, dynamic>),
      reminders: (json['reminders'] as List<dynamic>)
          .map((e) => DateTime.parse(e as String))
          .toList(),
    );

Map<String, dynamic> _$HabitToJson(Habit instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'color': const ColorConverter().toJson(instance.color),
      'goal': instance.goal,
      'icon': const IconConverter().toJson(instance.icon),
      'startDate': instance.startDate,
      'endDate': instance.endDate,
      'reminders': instance.reminders.map((e) => e.toIso8601String()).toList(),
    };
