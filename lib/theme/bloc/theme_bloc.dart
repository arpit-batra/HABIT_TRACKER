import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:habit_tracker/theme/bloc/theme_event.dart';
import 'package:habit_tracker/theme/bloc/theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  //This ThemeData will be the default theme data
  ThemeBloc()
      : super(ThemeState(
            isNightMode: false,
            themeData: ThemeData(
              primaryColor: const Color.fromARGB(255, 0, 140, 255),
              dividerColor: const Color.fromARGB(255, 63, 63, 63),
              textTheme: const TextTheme(
                titleMedium: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 5),
                titleSmall: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 4),
                bodyMedium: TextStyle(fontSize: 16),
              ),
            ))) {
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
  Stream<ThemeData> mapEventToState(ThemeEvent themeEvent) async* {
    if (themeEvent is LightModeSelected) {
      //Light Mode ThemeData

      yield ThemeData(
        primaryColor: Colors.blue, // set the primary color
        accentColor: Colors.blueAccent, // set the accent color
        scaffoldBackgroundColor:
            Colors.white, // set the background color of the scaffold
        backgroundColor:
            Colors.grey[100], // set the background color of the entire app
        dialogBackgroundColor:
            Colors.white, // set the background color of dialogs
        cardColor: Colors.white, // set the background color of cards
        textTheme: TextTheme(
          titleMedium: TextStyle(fontSize: 24),
        ),
        appBarTheme: AppBarTheme(
          backgroundColor:
              Colors.white, // set the background color of the app bar
          foregroundColor: Colors.black, // set the text color of the app bar
        ),
        iconTheme: IconThemeData(color: Colors.black), // set the color of icons
      );
    }
    if (themeEvent is DarkModeSelected) {
      //Dark Mode ThemeData
      yield ThemeData(
        primaryColor: Colors.blueGrey[900], // set the primary color
        accentColor: Colors.blueAccent, // set the accent color
        scaffoldBackgroundColor:
            Colors.grey[900], // set the background color of the scaffold
        backgroundColor:
            Colors.grey[800], // set the background color of the entire app
        dialogBackgroundColor:
            Colors.grey[800], // set the background color of dialogs
        cardColor: Colors.grey[800], // set the background color of cards
        textTheme: TextTheme(
          headline6:
              TextStyle(color: Colors.white), // set the text color of headlines
          bodyText2:
              TextStyle(color: Colors.white), // set the text color of body text
        ),
        appBarTheme: AppBarTheme(
          backgroundColor:
              Colors.grey[900], // set the background color of the app bar
          foregroundColor: Colors.white, // set the text color of the app bar
        ),
        iconTheme: IconThemeData(color: Colors.white),
      );
    }
  }
}
