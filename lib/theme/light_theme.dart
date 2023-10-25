import 'package:flutter/material.dart';

class LightTheme{
  static ThemeData lightTheme() => ThemeData(
    primaryColor: Colors.purple,
    errorColor: Colors.red,
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Colors.amber,
    ),
    bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: Colors.purple),
    textTheme: const TextTheme(
      titleMedium: TextStyle(
        fontFamily: 'Quicksand',
        fontWeight: FontWeight.bold,
        fontSize: 18,
        color: Colors.purple,
      ),
    ),
    appBarTheme: const AppBarTheme(
        titleTextStyle: TextStyle(
          fontFamily: 'Open Sans',
          fontWeight: FontWeight.bold,
          fontSize: 22,
        )
    ),
    brightness: Brightness.light,
      );

}