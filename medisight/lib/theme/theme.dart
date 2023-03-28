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
    canvasColor: Color.fromARGB(255, 22, 22, 22),
    appBarTheme: const AppBarTheme(
        foregroundColor: Color.fromARGB(255, 255, 255, 255),
        backgroundColor: Color.fromARGB(255, 22, 22, 22),
        elevation: 0.5,
        centerTitle: true),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        side: BorderSide(color: Color.fromARGB(255, 255, 214, 0), width: 2.5),
        foregroundColor: Color.fromARGB(255, 255, 214, 0),
        backgroundColor: Color.fromARGB(255, 22, 22, 22),
      ),
    ),
    // elevatedButtonTheme: ElevatedButtonThemeData(
    //   style: ElevatedButton.styleFrom(
    //     side: BorderSide(color: Color.fromARGB(255, 255, 72, 220), width: 2.5),
    //     foregroundColor: Color.fromARGB(255, 255, 72, 220),
    //     backgroundColor: Color.fromARGB(255, 22, 22, 22),
    //   ),
    // ),
  );
}
