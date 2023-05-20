import 'package:flutter/material.dart';

abstract class ThemeEvent {
  const ThemeEvent();
}

class LightModeSelected extends ThemeEvent {
  const LightModeSelected();
}

class DarkModeSelected extends ThemeEvent {
  const DarkModeSelected();
}

class ThemeColorChanged extends ThemeEvent {
  final Color newThemeColor;
  final Color newDarkThemeColor;
  final Color newLightThemeColor;
  const ThemeColorChanged(
      this.newThemeColor, this.newDarkThemeColor, this.newLightThemeColor);
}
