import 'package:habit_tracker/models/record.dart';

class RecordListEvent {
  RecordListEvent();
}

class AddOrUpdateRecord extends RecordListEvent {
  final Record record;
  AddOrUpdateRecord({required this.record});
}

class RemoveRecord extends RecordListEvent {
  final Record record;
  RemoveRecord({required this.record});
}
