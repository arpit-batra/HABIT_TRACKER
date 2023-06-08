import 'package:json_annotation/json_annotation.dart';

part 'goal_model.g.dart';

enum GoalUnit {
  count,
  steps,
  metre,
  km,
  min,
  hr,
  cal,
}

@JsonSerializable()
class Goal {
  Goal(
      {this.goalCount = 1, this.goalUnit = GoalUnit.count, this.frequency = 1});

  int goalCount;
  GoalUnit goalUnit;
  //Days after which the habit needs to be repeated.
  // 1 means every day
  // 2 means once every 2 days
  // 7 means weekly and so on.
  int frequency;

  static const goalUnits = {
    GoalUnit.count: "count",
    GoalUnit.steps: "steps",
    GoalUnit.metre: "metre",
    GoalUnit.km: "km",
    GoalUnit.min: "min",
    GoalUnit.hr: "hr",
    GoalUnit.cal: "cal",
  };

  static const freqencies = {1: "daily", 7: "weekly", 30: "montly"};

  copyWith({GoalUnit? goalUnit, int? goalCount, int? frequency}) {
    return Goal(
        goalUnit: goalUnit ?? this.goalUnit,
        goalCount: goalCount ?? this.goalCount,
        frequency: frequency ?? this.frequency);
  }

  static GoalUnit goalUnitFromString(String input) {
    switch (input) {
      case "GoalUnit.count":
        return GoalUnit.count;
      case "GoalUnit.steps":
        return GoalUnit.steps;
      case "GoalUnit.metre":
        return GoalUnit.metre;
      case "GoalUnit.km":
        return GoalUnit.km;
      case "GoalUnit.min":
        return GoalUnit.min;
      case "GoalUnit.hr":
        return GoalUnit.hr;
      case "GoalUnit.cal":
        return GoalUnit.cal;
      default:
        return GoalUnit.count;
    }
  }

  // Map<String, dynamic> toJson() {
  //   return {
  //     'goalCount': goalCount.toString(),
  //     'goalUnit': goalUnit.toString(),
  //     'frequency': frequency.toString(),
  //   };
  // }

  // factory Goal.fromJson(Map<String, dynamic> json) {
  //   return Goal(
  //       goalCount: int.parse(json['goalCount']),
  //       goalUnit: goalUnitFromString(json['goalUnit']),
  //       frequency: int.parse(json['frequency']));
  // }

  factory Goal.fromJson(Map<String, dynamic> json) => _$GoalFromJson(json);

  Map<String, dynamic> toJson() => _$GoalToJson(this);
}
