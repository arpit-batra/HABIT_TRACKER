import 'package:habit_tracker/models/date.dart';
import 'package:json_annotation/json_annotation.dart';

part 'record.g.dart';

@JsonSerializable()
class Record {
  String habitName;
  int countCompleted;
  Date date;

  Record(
      {required this.habitName,
      required this.countCompleted,
      required this.date});

  Record copyWith({String? habitName, int? countCompleted, Date? date}) {
    return Record(
        habitName: habitName ?? this.habitName,
        countCompleted: countCompleted ?? this.countCompleted,
        date: date ?? this.date);
  }

  factory Record.fromJson(Map<String, dynamic> json) => _$RecordFromJson(json);
  Map<String, dynamic> toJson() => _$RecordToJson(this);
}
