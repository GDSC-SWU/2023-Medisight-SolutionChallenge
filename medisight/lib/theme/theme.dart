import 'package:flutter/material.dart';

class MyThemes {
  static final lightTheme = ThemeData(
      brightness: Brightness.light,
      fontFamily: 'NotoSansKR',
      primaryColor: Color.fromARGB(255, 107, 134, 255),
      appBarTheme: const AppBarTheme(
          foregroundColor: Color.fromARGB(255, 0, 0, 0),
          backgroundColor: Color.fromARGB(255, 255, 255, 255),
          elevation: 0.0,
          centerTitle: true),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          foregroundColor: MaterialStateProperty.resolveWith<Color>(
              (states) => Colors.black),
          backgroundColor: MaterialStateProperty.resolveWith<Color>(
            (states) => Colors.blue.shade50,
          ),
        ),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: Colors.blue.shade50,
      ));

  static final darkTheme = ThemeData(
      brightness: Brightness.dark,
      primaryColor: Color.fromARGB(255, 255, 214, 0),
      fontFamily: 'NotoSansKR',
      canvasColor: Color.fromARGB(255, 22, 22, 22),
      appBarTheme: const AppBarTheme(
          foregroundColor: Color.fromARGB(255, 255, 255, 255),
          backgroundColor: Color.fromARGB(255, 22, 22, 22),
          elevation: 0.0,
          centerTitle: true),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          side: BorderSide(color: Color.fromARGB(255, 255, 214, 0), width: 2.5),
          foregroundColor: Color.fromARGB(255, 255, 214, 0),
          backgroundColor: Color.fromARGB(255, 22, 22, 22),
        ),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: Color.fromARGB(255, 255, 214, 0),
      ));
}
