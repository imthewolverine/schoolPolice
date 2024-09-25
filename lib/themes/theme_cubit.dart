import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThemeCubit extends Cubit<ThemeData> {
  ThemeCubit() : super(ThemeDataStyle.light);

  // Toggles between light and dark themes
  void toggleTheme() {
    emit(state.brightness == Brightness.dark
        ? ThemeDataStyle.light
        : ThemeDataStyle.dark);
  }
}

class ThemeDataStyle {
  static ThemeData light = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: ColorScheme.light(
      surface: Colors.grey.shade100,
      primary: Colors.blue, // Primary blue color for the text fields and accent
      secondary: Colors.blueAccent, // For Facebook and Google buttons
      background: Colors.white,
    ),
    buttonTheme: ButtonThemeData(
      buttonColor: Colors.yellow, // Yellow button for 'Нэвтрэх'
    ),
    inputDecorationTheme: InputDecorationTheme(
      fillColor: Colors.grey.shade300, // Light grey background for input fields
      filled: true,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide.none,
      ),
    ),
    textTheme: TextTheme(
      bodyLarge: TextStyle(color: Colors.black), // Black text for light mode
      bodyMedium: TextStyle(color: Colors.black54),
    ),
  );

  static ThemeData dark = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    scaffoldBackgroundColor:
        Color(0xFF00204A), // Dark blue background to match the template
    colorScheme: ColorScheme.dark(
      surface: Colors.blue.shade900,
      primary: Color(0xFF00204A), // Dark blue primary for the app background
      secondary: Colors.blueAccent, // For the Facebook/Google buttons
      background: Color(0xFF00204A), // Same dark blue background
      onPrimary: Colors.white,
      onSecondary: Colors.black,
    ),
    buttonTheme: ButtonThemeData(
      buttonColor: Color(0xFFFFD700), // Bright yellow color for buttons
      textTheme: ButtonTextTheme.primary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      fillColor: Colors.blueGrey.shade800, // Darker grey for input fields
      filled: true,
      hintStyle: TextStyle(color: Colors.white54), // Placeholder text color
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide.none,
      ),
    ),
    textTheme: TextTheme(
      bodyLarge: TextStyle(color: Colors.white), // White text for dark mode
      bodyMedium: TextStyle(color: Colors.white70),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.black,
        backgroundColor: Color(0xFFFFD700), // Text color for buttons
        textStyle: TextStyle(fontWeight: FontWeight.bold),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8), // Rounded button shape
        ),
      ),
    ),
  );
}
