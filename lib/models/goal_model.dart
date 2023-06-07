enum GoalUnit {
  count,
  steps,
  metre,
  km,
  min,
  hr,
  cal,
}

class Goal {
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

  Goal(
      {this.goalCount = 1, this.goalUnit = GoalUnit.count, this.frequency = 1});

  int goalCount;
  GoalUnit goalUnit;
  //Days after which the habit needs to be repeated.
  // 1 means every day
  // 2 means once every 2 days
  // 7 means weekly and so on.
  int frequency;

  copyWith({GoalUnit? goalUnit, int? goalCount, int? frequency}) {
    return Goal(
        goalUnit: goalUnit ?? this.goalUnit,
        goalCount: goalCount ?? this.goalCount,
        frequency: frequency ?? this.frequency);
  }
}
