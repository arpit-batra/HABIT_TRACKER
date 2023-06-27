import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_tracker/theme/bloc/theme_bloc.dart';
import 'package:habit_tracker/theme/bloc/theme_event.dart';
import 'package:habit_tracker/widgets/settings_tab/settings_button_wrapper.dart';

class NightModePicker extends StatelessWidget {
  const NightModePicker({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
            context: context,
            builder: (ctx) {
              return BottomSheet(
                  onClosing: () {},
                  builder: (ctx) {
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            "Night Mode",
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            context
                                .read<ThemeBloc>()
                                .add(const DarkModeSelected());
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text("Enabled"),
                                if (context.read<ThemeBloc>().state.isNightMode)
                                  Icon(
                                    Icons.check_circle_outline_sharp,
                                    color: Theme.of(context).primaryColor,
                                    size: 30,
                                  )
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            context
                                .read<ThemeBloc>()
                                .add(const LightModeSelected());
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text("Disabled"),
                                if (!context
                                    .read<ThemeBloc>()
                                    .state
                                    .isNightMode)
                                  Icon(
                                    Icons.check_circle_outline_sharp,
                                    color: Theme.of(context).primaryColor,
                                    size: 30,
                                  )
                              ],
                            ),
                          ),
                        )
                      ],
                    );
                  });
            });
      },
      child: SettingsButtonWrapper(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Night Mode",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            Text(context.read<ThemeBloc>().state.isNightMode
                ? "Enabled"
                : "Disabled"),
          ],
        ),
      ),
    );
  }
}
