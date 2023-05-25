class SelectedDateEvent {
  const SelectedDateEvent();
}

class SelectedDateChanged extends SelectedDateEvent {
  final DateTime newDate;
  const SelectedDateChanged({required this.newDate});
}
