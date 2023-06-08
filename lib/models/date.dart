import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'date.g.dart';

@JsonSerializable()
// ignore: must_be_immutable
class Date extends Equatable {
  late int date;
  late int month;
  late int year;

  Date({required this.date, required this.month, required this.year});

  Date.today() {
    final todaysDateTime = DateTime.now();
    date = todaysDateTime.day;
    month = todaysDateTime.month;
    year = todaysDateTime.year;
  }

  @override
  List<Object?> get props => [date, month, year];

  // Map<String, dynamic> toJson() {
  //   return {
  //     'date': date.toString(),
  //     'month': month.toString(),
  //     'year': year.toString()
  //   };
  // }

  // factory Date.fromJson(Map<String, dynamic> json) {
  //   return Date(
  //       date: int.parse(json['date']),
  //       month: int.parse(json['month']),
  //       year: int.parse(json['year']));
  // }

  Map<String, dynamic> toJson() => _$DateToJson(this);

  factory Date.fromJson(Map<String, dynamic> json) => _$DateFromJson(json);
}
