import 'package:flutter/material.dart';

class MyThemes {
  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    appBarTheme: const AppBarTheme(
        foregroundColor: Color.fromARGB(255, 0, 0, 0),
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        elevation: 0.5,
        centerTitle: true),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith<Color>(
          (states) => Color.fromARGB(255, 107, 134, 255),
        ),
      ),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Color.fromARGB(255, 107, 134, 255),
    ),
    textTheme: const TextTheme(
        headline4: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
  );

  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
    appBarTheme: const AppBarTheme(
        foregroundColor: Color.fromARGB(255, 255, 255, 255),
        backgroundColor: Color.fromARGB(255, 46, 46, 46),
        elevation: 0.5,
        centerTitle: true),
  );
}
