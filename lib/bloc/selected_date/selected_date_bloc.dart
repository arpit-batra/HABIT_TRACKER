import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_tracker/bloc/selected_date/selected_date_event.dart';
import 'package:habit_tracker/bloc/selected_date/selected_date_state.dart';
import 'package:habit_tracker/models/date.dart';

class SelectedDateBloc extends Bloc<SelectedDateEvent, SelectedDateState> {
  SelectedDateBloc() : super(SelectedDateState(selectedDate: Date.today())) {
    on((SelectedDateChanged event, emit) {
      emit(SelectedDateState(selectedDate: event.newDate));
    });
  }
}
