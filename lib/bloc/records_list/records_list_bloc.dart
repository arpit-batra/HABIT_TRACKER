import 'dart:convert';

import 'package:habit_tracker/bloc/records_list/records_list_event.dart';
import 'package:habit_tracker/bloc/records_list/records_list_state.dart';
import 'package:habit_tracker/models/record.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class RecordListBloc extends HydratedBloc<RecordsListEvent, RecordsListState> {
  RecordListBloc() : super(RecordsListState(recordList: [])) {
    on((AddOrUpdateRecord event, emit) {
      if (state.recordList
          .where((element) =>
              element.habitName == event.record.habitName &&
              element.date == event.record.date)
          .isEmpty) {
        emit(RecordsListState(recordList: [...state.recordList, event.record]));
      } else {
        final tempStateList = state.recordList;
        tempStateList
            .lastWhere((element) =>
                element.habitName == event.record.habitName &&
                element.date == event.record.date)
            .countCompleted = event.record.countCompleted;
        emit(RecordsListState(recordList: tempStateList));
      }
    });

    on((RemoveRecord event, emit) {
      final temp = state.recordList;
      temp.remove(event.record);
      emit(RecordsListState(recordList: temp));
    });

    on((RemoveRecordsOfAHabit event, emit) {
      final recordsTemp = state.recordList;
      recordsTemp
          .removeWhere((element) => element.habitName == event.habit.name);
      emit(RecordsListState(recordList: recordsTemp));
    });
  }

  @override
  Map<String, dynamic>? toJson(RecordsListState state) {
    return {"records": jsonEncode(state.recordList)};
  }

  @override
  RecordsListState? fromJson(Map<String, dynamic> json) {
    List<dynamic> jsonList = jsonDecode(json["records"]);
    List<Record> recordList = [];
    jsonList.forEach((recordJson) {
      recordList.add(Record.fromJson(recordJson));
    });
    return RecordsListState(recordList: recordList);
  }
}
