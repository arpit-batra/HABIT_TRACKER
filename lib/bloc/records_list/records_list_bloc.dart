import 'dart:convert';

import 'package:habit_tracker/bloc/records_list/records_list_event.dart';
import 'package:habit_tracker/bloc/records_list/records_list_state.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class RecordListBloc extends HydratedBloc<RecordListEvent, RecordsListState> {
  RecordListBloc() : super(RecordsListState(recordList: []));

  @override
  Map<String, dynamic>? toJson(RecordsListState state) {
    return {"records": jsonEncode(state.recordList)};
  }

  @override
  RecordsListState? fromJson(Map<String, dynamic> json) {
    return RecordsListState(recordList: jsonDecode(json['records']));
  }
}
