import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_tracker/bloc/selected_date/selected_date_bloc.dart';
import 'package:habit_tracker/bloc/selected_date/selected_date_event.dart';
import 'package:habit_tracker/bloc/selected_date/selected_date_state.dart';
import 'package:habit_tracker/helper/date_helper.dart';
import 'package:habit_tracker/models/date.dart';

class DateWidget extends StatelessWidget {
  const DateWidget({required this.date, required this.totalWidth, super.key});
  final Date date;
  final double totalWidth;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context
            .read<SelectedDateBloc>()
            .add(SelectedDateChanged(newDate: date));
      },
      child: BlocBuilder<SelectedDateBloc, SelectedDateState>(
          builder: (context, state) {
        return Column(
          children: [
            Container(
              width: totalWidth / 7,
              padding: const EdgeInsets.all(3),
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                        color: Theme.of(context).textTheme.titleMedium!.color!,
                        width: 1)),
                child: Column(
                  children: [
                    Text(date.date.toString()),
                    Text(DateHelper
                        .weekDaysArray[
                            DateHelper.convertDateToDateTime(date).weekday - 1]
                        .leadingChar)
                  ],
                ),
              ),
            ),
            if (state.selectedDate == date)
              Container(
                height: 10,
                width: 10,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Theme.of(context).textTheme.titleMedium!.color!),
              )
          ],
        );
      }),
    );
  }
}
