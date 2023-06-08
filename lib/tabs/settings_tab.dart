import 'package:flutter/material.dart';
import 'package:habit_tracker/widgets/settings_tab/night_mode_picker.dart';
import 'package:habit_tracker/widgets/settings_tab/theme_color_picker.dart';
import 'package:habit_tracker/widgets/tab_headings.dart';

class SettingsTab extends StatelessWidget {
  const SettingsTab({super.key});

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    return SizedBox(
      height: double.infinity,
      width: deviceWidth,
      child: SafeArea(
        child: Column(
          children: [
            const TabHeading(heading: "Settings"),
            NightModePicker(),
            ThemeColorPicker(),
          ],
        ),
      ),
    );
  }
}
