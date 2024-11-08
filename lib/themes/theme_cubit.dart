import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThemeCubit extends Cubit<ThemeData> {
  ThemeCubit() : super(ThemeDataStyle.light);

  void toggleTheme() {
    emit(state.brightness == Brightness.dark
        ? ThemeDataStyle.light
        : ThemeDataStyle.dark);
  }
}

class ThemeDataStyle {
  // Light Theme
  static ThemeData light = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: const ColorScheme.light(
      surface: Color.fromRGBO(230, 230, 230, 1),
      primary: Color.fromRGBO(1, 5, 54, 1),
      secondary: Color(0xFFFFFF00),
      surfaceContainerHighest: Color.fromRGBO(1, 5, 54, 1),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Color.fromRGBO(128, 0, 0, 1),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      fillColor: Color.fromRGBO(200, 200, 200, 1),
      filled: true,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide.none,
      ),
    ),
    textTheme: const TextTheme(
      displayLarge: TextStyle(color: Color(0xFF010536)),
      displayMedium: TextStyle(color: Colors.black87),
      displaySmall: TextStyle(color: Colors.black54),
      headlineMedium: TextStyle(color: Colors.black),
      headlineSmall: TextStyle(color: Colors.grey),
      titleLarge: TextStyle(color: Colors.black),
      titleMedium: TextStyle(color: Colors.black87),
      titleSmall: TextStyle(color: Colors.black54),
      bodyLarge: TextStyle(color: Colors.white),
      bodyMedium: TextStyle(color: Colors.black54),
      bodySmall: TextStyle(color: Colors.black38),
      labelLarge: TextStyle(color: Colors.white),
      labelSmall: TextStyle(color: Colors.black45),
    ),
  );

  // Dark Theme
  static ThemeData dark = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: const Color(0xFF00204A),
    colorScheme: ColorScheme.dark(
      surface: Colors.blue.shade900,
      primary: const Color(0xFF00204A),
      secondary: Colors.blueAccent,
      onPrimary: Colors.white,
      onSecondary: Colors.black,
    ),
    buttonTheme: ButtonThemeData(
      buttonColor: const Color(0xFFFFD700),
      textTheme: ButtonTextTheme.primary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      fillColor: Colors.blueGrey.shade800,
      filled: true,
      hintStyle: const TextStyle(color: Colors.white54),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide.none,
      ),
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Colors.white),
      bodyMedium: TextStyle(color: Colors.white70),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.black,
        backgroundColor: const Color(0xFFFFD700),
        textStyle: const TextStyle(fontWeight: FontWeight.bold),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    ),
  );
}
