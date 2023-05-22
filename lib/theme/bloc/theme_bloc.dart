import 'package:flutter/material.dart';
import 'package:habit_tracker/theme/bloc/theme_event.dart';
import 'package:habit_tracker/theme/bloc/theme_state.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:json_theme/json_theme.dart';

final ThemeState initialTheme = ThemeState(
  isNightMode: false,
  themeData: ThemeData(
    primaryColor: const Color.fromARGB(255, 0, 140, 255),
    dividerColor: const Color.fromARGB(255, 63, 63, 63),
    textTheme: const TextTheme(
      titleMedium: TextStyle(
          fontSize: 28, fontWeight: FontWeight.w800, letterSpacing: 5),
      titleSmall: TextStyle(
          fontSize: 20, fontWeight: FontWeight.w800, letterSpacing: 4),
      bodyMedium: TextStyle(fontSize: 16),
    ),
  ),
);

class ThemeBloc extends HydratedBloc<ThemeEvent, ThemeState> {
  //This ThemeData will be the default theme data
  ThemeBloc() : super(initialTheme) {
    on((ThemeColorChanged event, emit) {
      emit(ThemeState(
          isNightMode: state.isNightMode,
          themeData: state.themeData.copyWith(
            primaryColor: event.newThemeColor,
            primaryColorDark: event.newDarkThemeColor,
            primaryColorLight: event.newLightThemeColor,
          )));
    });
    on((DarkModeSelected event, emit) {
      emit(
        ThemeState(
          isNightMode: true,
          themeData: state.themeData.copyWith(
            scaffoldBackgroundColor: Colors.black,
            dialogBackgroundColor: Colors.black,
            cardColor: Colors.black,
            iconTheme: const IconThemeData(color: Colors.white),
            bottomSheetTheme: const BottomSheetThemeData(
                backgroundColor: Color.fromARGB(255, 77, 77, 77)),
            dividerColor: const Color.fromARGB(255, 211, 211, 211),
            textTheme: const TextTheme(
              titleMedium: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 5,
                  color: Colors.white),
              titleSmall: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 4,
                  color: Colors.white),
              bodyMedium: TextStyle(fontSize: 16, color: Colors.white),
            ),
          ),
        ),
      );
    });
    on((LightModeSelected event, emit) {
      emit(
        ThemeState(
          isNightMode: false,
          themeData: state.themeData.copyWith(
            scaffoldBackgroundColor: Colors.white,
            dialogBackgroundColor: Colors.white,
            cardColor: Colors.white,
            iconTheme: const IconThemeData(color: Colors.black),
            bottomSheetTheme:
                const BottomSheetThemeData(backgroundColor: Colors.white),
            dividerColor: const Color.fromARGB(255, 63, 63, 63),
            textTheme: const TextTheme(
              titleMedium: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 5,
                  color: Colors.black),
              titleSmall: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 4,
                  color: Colors.black),
              bodyMedium: TextStyle(fontSize: 16, color: Colors.black),
            ),
          ),
        ),
      );
    });
  }

  @override
  ThemeState? fromJson(Map<String, dynamic> json) {
    return ThemeState(
        isNightMode: json["isNightMode"],
        themeData: ThemeDecoder.decodeThemeData(json["themeData"]) ??
            initialTheme.themeData);
  }

  @override
  Map<String, dynamic>? toJson(ThemeState state) {
    return {
      "isNightMode": state.isNightMode,
      "themeData": ThemeEncoder.encodeThemeData(state.themeData)
    };
    // return {"isNightMode": state.isNightMode, "themeDataPrimaryColor": state.themeData.primaryColor,"themeDataPrimaryColorDark":state.themeData.primaryColorDark,"themeDataPrimaryColorLight":state.themeData.primaryColorLight,"themeDataDividerColor":state.themeData.dividerColor,"theme"};
  }
}
