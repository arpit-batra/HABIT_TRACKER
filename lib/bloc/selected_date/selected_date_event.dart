import 'package:habit_tracker/models/date.dart';

class SelectedDateEvent {
  const SelectedDateEvent();
}

class SelectedDateChanged extends SelectedDateEvent {
  final Date newDate;
  const SelectedDateChanged({required this.newDate});
}
