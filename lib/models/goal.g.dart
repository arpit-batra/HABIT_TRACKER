// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'goal.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Goal _$GoalFromJson(Map<String, dynamic> json) => Goal(
      goalCount: json['goalCount'] as int? ?? 1,
      goalUnit: $enumDecodeNullable(_$GoalUnitEnumMap, json['goalUnit']) ??
          GoalUnit.count,
      frequency: json['frequency'] as int? ?? 1,
    );

Map<String, dynamic> _$GoalToJson(Goal instance) => <String, dynamic>{
      'goalCount': instance.goalCount,
      'goalUnit': _$GoalUnitEnumMap[instance.goalUnit]!,
      'frequency': instance.frequency,
    };

const _$GoalUnitEnumMap = {
  GoalUnit.count: 'count',
  GoalUnit.steps: 'steps',
  GoalUnit.metre: 'metre',
  GoalUnit.km: 'km',
  GoalUnit.min: 'min',
  GoalUnit.hr: 'hr',
  GoalUnit.cal: 'cal',
};
