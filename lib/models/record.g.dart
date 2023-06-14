// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'record.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Record _$RecordFromJson(Map<String, dynamic> json) => Record(
      habitName: json['habitName'] as String,
      countCompleted: json['countCompleted'] as int,
      date: Date.fromJson(json['date'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RecordToJson(Record instance) => <String, dynamic>{
      'habitName': instance.habitName,
      'countCompleted': instance.countCompleted,
      'date': instance.date,
    };
