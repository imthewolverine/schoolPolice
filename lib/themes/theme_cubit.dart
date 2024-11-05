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
      tertiary: Color.fromRGBO(128, 0, 0, 1),
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
      displayLarge: TextStyle(color: Color(0xFF010536)), // Replaces headline1
      displayMedium: TextStyle(color: Colors.black87),    // Replaces headline2
      displaySmall: TextStyle(color: Colors.black54),     // Replaces headline3
      headlineMedium: TextStyle(color: Colors.black),     // Replaces headline4
      headlineSmall: TextStyle(color: Colors.grey),       // Replaces headline5
      titleLarge: TextStyle(color: Colors.black),         // Replaces headline6
      titleMedium: TextStyle(color: Colors.black87),      // Replaces subtitle1
      titleSmall: TextStyle(color: Colors.black54),       // Replaces subtitle2
      bodyLarge: TextStyle(color: Colors.black87),        // Replaces bodyText1
      bodyMedium: TextStyle(color: Colors.black54),       // Replaces bodyText2
      bodySmall: TextStyle(color: Colors.black38),        // Replaces caption
      labelLarge: TextStyle(color: Colors.white),         // Replaces button
      labelSmall: TextStyle(color: Colors.black45),       // Replaces overline
    ),
  );

  // Dark Theme
  static ThemeData dark = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: const Color(0xFF00204A), // Dark blue background
    colorScheme: ColorScheme.dark(
      surface: Colors.blue.shade900, // Darker surface color for dark mode
      primary: const Color(0xFF00204A), // Dark blue primary color
      secondary: Colors.blueAccent, // Accent color for buttons like Facebook/Google
      onPrimary: Colors.white, // Text color on primary elements
      onSecondary: Colors.black, // Text color on secondary elements
    ),
    buttonTheme: ButtonThemeData(
      buttonColor: const Color(0xFFFFD700), // Bright yellow buttons
      textTheme: ButtonTextTheme.primary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      fillColor: Colors.blueGrey.shade800, // Dark grey for input fields
      filled: true,
      hintStyle: const TextStyle(color: Colors.white54), // Placeholder text color
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide.none,
      ),
    ),
    textTheme: const TextTheme(
      displayLarge: TextStyle(color: Colors.white70),       // Replaces headline1
      displayMedium: TextStyle(color: Colors.white60),       // Replaces headline2
      displaySmall: TextStyle(color: Colors.white54),        // Replaces headline3
      headlineMedium: TextStyle(color: Colors.white),        // Replaces headline4
      headlineSmall: TextStyle(color: Colors.white60),       // Replaces headline5
      titleLarge: TextStyle(color: Colors.white),            // Replaces headline6
      titleMedium: TextStyle(color: Colors.white70),         // Replaces subtitle1
      titleSmall: TextStyle(color: Colors.white60),          // Replaces subtitle2
      bodyLarge: TextStyle(color: Colors.white),             // Replaces bodyText1
      bodyMedium: TextStyle(color: Colors.white70),          // Replaces bodyText2
      bodySmall: TextStyle(color: Colors.white54),           // Replaces caption
      labelLarge: TextStyle(color: Colors.black),            // Replaces button
      labelSmall: TextStyle(color: Colors.white38),          // Replaces overline
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.black, // Button text color
        backgroundColor: const Color(0xFFFFD700), // Bright yellow background
        textStyle: const TextStyle(fontWeight: FontWeight.bold),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8), // Rounded button shape
        ),
      ),
    ),
  );
}
