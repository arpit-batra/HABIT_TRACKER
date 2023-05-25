import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_tracker/bloc/selected_date/selected_date_bloc.dart';
import 'package:habit_tracker/bloc/selected_date/selected_date_event.dart';
import 'package:habit_tracker/bloc/selected_date/selected_date_state.dart';
import 'package:habit_tracker/helper/date_helper.dart';

class DateWidget extends StatelessWidget {
  const DateWidget({required this.date, super.key});
  final DateTime date;

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
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                      color: Theme.of(context).textTheme.titleMedium!.color!,
                      width: 1)),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(14, 8, 14, 8),
                child: FittedBox(
                  fit: BoxFit.contain,
                  child: Column(
                    children: [
                      Text(date.day.toString()),
                      Text(DateHelper
                          .weekDaysArray[date.weekday - 1].leadingChar)
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 4,
            ),
            if (DateHelper.onlyDateFromDateTime(state.selectedDate) ==
                DateHelper.onlyDateFromDateTime(date))
              Container(
                height: 10,
                width: 10,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: Colors.black),
              )
          ],
        );
      }),
    );
  }
}
