import 'package:flutter/material.dart';
import 'package:habit_tracker/bloc/selected_date/selected_date_bloc.dart';
import 'package:habit_tracker/bloc/selected_date/selected_date_state.dart';
import 'package:habit_tracker/helper/date_helper.dart';
import 'package:habit_tracker/widgets/home_tab/date_selector.dart';
import 'package:habit_tracker/widgets/tab_headings.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    return BlocProvider(
      create: (context) => SelectedDateBloc(),
      child: SizedBox(
        width: deviceWidth,
        height: double.infinity,
        child: SafeArea(
            child: Column(
          children: [
            BlocBuilder<SelectedDateBloc, SelectedDateState>(
                builder: (context, state) {
              final homeHeading = DateHelper.homeTabHeading(state.selectedDate);
              return TabHeading(heading: homeHeading);
            }),
            DateSelector()
          ],
        )),
      ),
    );
  }
}
