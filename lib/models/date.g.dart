// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'date.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Date _$DateFromJson(Map<String, dynamic> json) => Date(
      date: json['date'] as int,
      month: json['month'] as int,
      year: json['year'] as int,
    );

Map<String, dynamic> _$DateToJson(Date instance) => <String, dynamic>{
      'date': instance.date,
      'month': instance.month,
      'year': instance.year,
    };
