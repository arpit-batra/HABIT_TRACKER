import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:habit_tracker/theme/bloc/theme_bloc.dart';
import 'package:habit_tracker/theme/bloc/theme_event.dart';
import 'package:habit_tracker/widgets/settings_tab/settings_button_wrapper.dart';

class ThemeColorPicker extends StatelessWidget {
  ThemeColorPicker({super.key});
  final colorChoices = {
    const Color.fromARGB(255, 236, 102, 93): {
      'dark': const Color.fromARGB(255, 149, 48, 40),
      'light': const Color.fromARGB(255, 255, 153, 146)
    },
    const Color.fromARGB(255, 18, 183, 24): {
      'dark': const Color.fromARGB(255, 0, 116, 4),
      'light': const Color.fromARGB(255, 96, 255, 99),
    },
    const Color.fromARGB(255, 0, 140, 255): {
      'dark': const Color.fromARGB(255, 0, 88, 159),
      'light': const Color.fromARGB(255, 96, 184, 255),
    },
    const Color.fromARGB(255, 252, 170, 39): {
      'dark': Color.fromARGB(255, 206, 94, 8),
      'light': Color.fromARGB(255, 255, 209, 122),
    },
    const Color.fromARGB(255, 188, 38, 225): {
      'dark': Color.fromARGB(255, 91, 2, 114),
      'light': Color.fromARGB(255, 243, 152, 254),
    },
  };
  @override
  Widget build(BuildContext context) {
    return SettingsButtonWrapper(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Theme Color",
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(
            height: 18,
          ),
          BlockPicker(
              pickerColor:
                  context.read<ThemeBloc>().state.themeData.primaryColor,
              availableColors: colorChoices.keys.toList(),
              layoutBuilder: (context, colors, child) {
                return Wrap(
                  children: colors.map((e) => child(e)).toList(),
                );
              },
              itemBuilder: (color, isCurrentColor, changeColor) {
                return GestureDetector(
                  onTap: changeColor,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 16, 16),
                    child: Stack(
                      children: [
                        Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: color,
                              boxShadow: [
                                BoxShadow(
                                    color: color,
                                    blurRadius: 6,
                                    offset: const Offset(1.4, 1.4))
                              ]),
                        ),
                        Positioned(
                          right: 0,
                          bottom: 0,
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 400),
                            height: isCurrentColor ? 18 : 0,
                            width: isCurrentColor ? 18 : 0,
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle, color: Colors.grey),
                            child: Icon(
                              Icons.check,
                              color: Colors.white,
                              size: isCurrentColor ? 12 : 0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
              onColorChanged: (color) {
                context.read<ThemeBloc>().add(ThemeColorChanged(
                    color,
                    colorChoices[color]!['dark']!,
                    colorChoices[color]!['light']!));
              })
        ],
      ),
    );
  }
}
